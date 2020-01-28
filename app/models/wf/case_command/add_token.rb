# frozen_string_literal: true

module Wf::CaseCommand
  class AddToken
    prepend SimpleCommand
    attr_reader :wf_case, :place
    def initialize(wf_case, place)
      @wf_case = wf_case
      @place = place
    end

    def call
      wf_case.tokens.create!(
        workflow: wf_case.workflow,
        place: place,
        state: :free
      )
    end
  end
end
