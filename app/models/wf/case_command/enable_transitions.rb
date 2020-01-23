module Wf::CaseCommand
  class EnableTransitions
    prepend SimpleCommand
    attr_reader :wf_case
    def initialize(wf_case)
      @wf_case = wf_case
    end

    def call
      wf_case.workitems.enabled.each do |workitem|
        if not wf_case.can_fire?(workitem.transition)
          workitem.update!(state: :overridden, overridden_at: Time.now)
        end
      end
      wf_case.workflow.transitions.each do |transition|
        if wf_case.can_fire?(transition) && !transition.workitems.where(state: [:enabled, :started]).exists？
          wf_case.workitems.create!(workflow: wf_case.workflow, transition: transition, state: :enabled)
        end
      end
      # TODO execute_unassigned_callback
      # TODO execute transition callback
      # TODO set workitem assignments
    end
  end
end