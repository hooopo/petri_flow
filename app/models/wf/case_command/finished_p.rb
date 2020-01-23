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
      end_place_token_num = wf_case.tokens.where(place: end_place).count
      if end_place_token_num == 0
        return false
      else
        free_and_locked_token_num = wf_case.tokens.where(place: end_place).where(state: %i[free locked]).count
        raise("The workflow net is misconstructed: Some parallel executions have not finished.") if free_and_locked_token_num > 1

        wf_case.tokens.where(place: end_place).where(state: %i[free locked]).find_each do |_token|
          ConsumeToken.call(wf_case, end_place)
        end
        wf.finished!
        return true
      end
    end
  end
end
