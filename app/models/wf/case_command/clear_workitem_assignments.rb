# frozen_string_literal: true

module Wf::CaseCommand
  class ClearWorkitemAssignments
    prepend SimpleCommand
    attr_reader :workitem, :permanent
    def initialize(workitem, permanent = true)
      @workitem = workitem
      @permanent = permanent
    end

    def call
      Wf::ApplicationRecord.transaction do
        ClearManualAssignments.call(workitem.case, workitem.transition) if permanent
        workitem.workitem_assignments.delete_all
        workitem.transition.unassignment_callback.constantize.new(workitem.id).perform
      end
    end
  end
end
