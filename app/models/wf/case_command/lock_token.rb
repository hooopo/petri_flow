# frozen_string_literal: true

module Wf::CaseCommand
  class LockToken
    prepend SimpleCommand
    attr_reader :wf_case, :place, :workitem
    def initialize(wf_case, place, workitem)
      @wf_case = wf_case
      @place = place
      @workitem = workitem
    end

    def call
      wf_case.tokens.free.where(place: place).limit(1).update_all(
        state: :locked,
        locked_at: Time.zone.now,
        locked_workitem_id: workitem.id
      )
    end
  end
end
