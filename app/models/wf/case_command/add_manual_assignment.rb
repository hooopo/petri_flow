# frozen_string_literal: true

module Wf::CaseCommand
  class AddManualAssignment
    prepend SimpleCommand
    attr_reader :wf_case, :transition, :party
    def initialize(wf_case, transition, party)
      @wf_case = wf_case
      @transition = transition
      @party = party
    end

    def call
      wf_case.case_assignments.find_or_create_by!(transition: transition, party: party)
    end
  end
end
