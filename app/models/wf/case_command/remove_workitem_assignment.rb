# frozen_string_literal: true

module Wf::CaseCommand
  class RemoveWorkitemAssignment
    prepend SimpleCommand
    attr_reader :workitem, :party, :permanent
    def initialize(workitem, party, permanent = true)
      @workitem = workitem
      @party    = party
      @permanent = permanent
    end

    def call
      return if party.nil?

      RemoveManualAssignment.call(workitem.case, workitem.transition, party) if permanent
      workitem.workitem_assignments.where(party: party).first&.destroy

      workitem.transition.unassignment_callback.constantize.new(workitem.id).perform_now if workitem.workitem_assignments.count == 0
    end
  end
end
