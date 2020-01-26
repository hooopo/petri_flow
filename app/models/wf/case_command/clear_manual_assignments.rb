# frozen_string_literal: true

module Wf::CaseCommand
  class ClearManualAssignments
    prepend SimpleCommand
    attr_reader :wf_case, :transition
    def initialize(wf_case, transition)
      @wf_case = wf_case
      @transition = transition
    end

    def call
      wf_case.case_assignments.where(transition: transition).find_each(&:destroy)
    end
  end
end
