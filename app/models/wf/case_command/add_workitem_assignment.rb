# frozen_string_literal: true

module Wf::CaseCommand
  class AddWorkitemAssignment
    prepend SimpleCommand
    attr_reader :workitem, :party, :permanent
    def initialize(workitem, party, permanent = true)
      @workitem = workitem
      @party    = party
      @permanent = permanent
    end

    def call
      return if party.nil?

      if permanent
        AddManualAssignment.call(workitem.case, workitem.transition, party)
        # TODO: notifi
      end
    end
  end
end
