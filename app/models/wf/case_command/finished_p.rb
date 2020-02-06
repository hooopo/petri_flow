# frozen_string_literal: true

module Wf::CaseCommand
  class FinishedP
    prepend SimpleCommand
    attr_reader :wf_case
    def initialize(wf_case)
      @wf_case = wf_case
    end

    def call
      return true if wf_case.finished?

      end_place = wf_case.workflow.places.end.first
      end_place_token_num = Wf::ApplicationRecord.uncached { wf_case.tokens.where(place: end_place).count }
      if end_place_token_num == 0
        false
      else
        free_and_locked_token_num = wf_case.tokens.where(place: end_place).where(state: %i[free locked]).count
        raise("The workflow net is misconstructed: Some parallel executions have not finished.") if free_and_locked_token_num > 1

        ConsumeToken.call(wf_case, end_place)
        wf_case.finished!
        true
      end
    end
  end
end
