# frozen_string_literal: true

module Wf::CaseCommand
  class FinishWorkitem
    prepend SimpleCommand
    attr_reader :workitem
    def initialize(workitem)
      @workitem = workitem
    end

    def call
      Wf::ApplicationRecord.transaction do
        if workitem.forked?
          workitem.update!(finished_at: Time.zone.now, state: :finished)
          Wf::Workitem.increment_counter(:children_finished_count, workitem.parent_id)
          if parent = workitem.parent
            if (parent.children_finished_count >= parent.children_count) || workitem.transition.finish_condition.constantize.new.perform(workitem)
              parent.children.where(state: %i[started enabled]).find_each do |wi|
                wi.update!(overridden_at: Time.zone.now, state: :overridden)
              end
              FireTransitionInternal.call(parent)
              SweepAutomaticTransitions.call(parent.case)
            end
          end
        else
          FireTransitionInternal.call(workitem)
          SweepAutomaticTransitions.call(workitem.case)
        end
      end
    end
  end
end
