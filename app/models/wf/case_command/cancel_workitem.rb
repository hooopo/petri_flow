# frozen_string_literal: true

module Wf::CaseCommand
  class CancelWorkitem
    prepend SimpleCommand
    attr_reader :workitem
    def initialize(workitem)
      @workitem = workitem
    end

    def call
      raise("The workitem is not in state #{workitem.state}") unless workitem.started?

      Wf::ApplicationRecord.transaction do
        workitem.update!(state: :canceled, canceled_at: Time.zone.now)
        ReleaseToken.call(workitem)
        SweepAutomaticTransitions.call(workitem.case)
      end
    end
  end
end
