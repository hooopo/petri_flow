# frozen_string_literal: true

module Wf
  class FireTimedWorkitemJob < ApplicationJob
    queue_as :default

    def perform(workitem_id)
      item = Wf::Workitem.find(workitem_id)
      if item.trigger_time && item.enabled? && item.case.active?
        CaseCommand::FireTransitionInternal.call(item)
        CaseCommand::SweepAutomaticTransitions.call(item.case)
      end
    end
  end
end
