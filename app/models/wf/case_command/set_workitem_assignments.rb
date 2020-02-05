# frozen_string_literal: true

module Wf::CaseCommand
  class SetWorkitemAssignments
    prepend SimpleCommand
    attr_reader :workitem
    def initialize(workitem)
      @workitem = workitem
    end

    def call
      ActiveRecord::Base.transaction do
        has_case_ass = false
        workitem.case.case_assignments.where(transition: workitem.transition).find_each do |case_ass|
          AddWorkitemAssignment.call(workitem, case_ass.party, false)
          has_case_ass = true
        end

        unless has_case_ass
          callback_values = workitem.transition.assignment_callback.constantize.new(workitem.id).perform
          if callback_values.present?
            # TODO: do assignment for callback.
          else
            workitem.transition.transition_static_assignments.each do |static_assignment|
              AddWorkitemAssignment.call(workitem, static_assignment.party, false)
            end
          end
        end
      end
    end
  end
end
