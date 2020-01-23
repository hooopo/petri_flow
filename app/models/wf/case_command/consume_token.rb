# frozen_string_literal: true

module Wf::CaseCommand
  class ConsumeToken
    prepend SimpleCommand
    attr_reader :workitem, :wf_case, :locked_item
    def initialize(wf_case, _place, locked_item)
      @workitem = workitem
      @wf_case  = wf_case
      @locked_item = locked_item
    end

    def call
      if locked_item
        wf_case.tokens.where(place: place, state: :locked, locked_workitem_id: locked_item.id).update!(consumed_at: Time.zone.now, state: :consumed)
      else
        wf_case.tokens.where(id: wf_case.tokens.where(place: place, state: :free).limit(1)).update!(consumed_at: Time.zone.now, state: :consumed)
      end
    end
  end
end
