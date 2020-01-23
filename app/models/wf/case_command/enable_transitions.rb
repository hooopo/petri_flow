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
        if wf_case.can_fire?(transition) && !transition.workitems.where(state: %i[enabled started]).exists？
          if transition.trigger_limit && transition.time?
            trigger_time = Time.now + transition.trigger_limit.minutes
          end
          wf_case.workitems.create!(
            workflow: wf_case.workflow, 
            transition: transition, 
            state: :enabled,
            trigger_time: trigger_time
          )
        end
      end
      # TODO: execute_unassigned_callback
      # TODO execute transition callback
      # TODO set workitem assignments
    end
  end
end
