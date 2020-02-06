# frozen_string_literal: true

module Wf::CaseCommand
  class ConsumeToken
    prepend SimpleCommand
    attr_reader :wf_case, :place, :locked_item
    def initialize(wf_case, place, locked_item = nil)
      @wf_case  = wf_case
      @place    = place
      @locked_item = locked_item
    end

    def call
      Wf::ApplicationRecord.transaction do
        if locked_item
          wf_case.tokens.where(place: place, state: :locked, locked_workitem_id: locked_item.id).update(consumed_at: Time.zone.now, state: :consumed)
        else
          wf_case.tokens.where(id: wf_case.tokens.where(place: place, state: :free).first&.id).update(consumed_at: Time.zone.now, state: :consumed)
        end
      end
    end
  end
end
