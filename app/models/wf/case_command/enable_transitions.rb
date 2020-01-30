# frozen_string_literal: true

module Wf::CaseCommand
  class EnableTransitions
    prepend SimpleCommand
    attr_reader :wf_case
    def initialize(wf_case)
      @wf_case = wf_case
    end

    def call
      wf_case.workitems.enabled.each do |workitem|
        workitem.update!(state: :overridden, overridden_at: Time.zone.now) unless wf_case.can_fire?(workitem.transition)
      end
      wf_case.workflow.transitions.each do |transition|
        next unless wf_case.can_fire?(transition) && !transition.workitems.where(case: wf_case, state: %i[enabled started]).exists?

        trigger_time = Time.zone.now + transition.trigger_limit.minutes if transition.trigger_limit && transition.time?
        workitem = wf_case.workitems.create!(
          workflow: wf_case.workflow,
          transition: transition,
          state: :enabled,
          trigger_time: trigger_time
        )
        Wf::FireTimedWorkitemJob.set(wait: transition.trigger_limit.minutes).perform_later(workitem.id) if trigger_time
        SetWorkitemAssignments.call(workitem)
        workitem.transition.unassignment_callback.constantize.new(workitem.id).perform_now if workitem.workitem_assignments.count == 0
      end
    end
  end
end
