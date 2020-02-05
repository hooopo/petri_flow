# frozen_string_literal: true

module Wf::CaseCommand
  class SweepTimedTransitions
    prepend SimpleCommand

    def call
      ActiveRecord::Base.transaction do
        Wf::Workitem.enabled.where("trigger_time <= ?", Time.zone.now).find_each do |item|
          FireTransitionInternal.call(item)
          SweepAutomaticTransitions.call(item.case)
        end
      end
    end
  end
end
