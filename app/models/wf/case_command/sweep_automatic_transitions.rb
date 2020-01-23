# frozen_string_literal: true

module Wf::CaseCommand
  class SweepAutomaticTransitions
    prepend SimpleCommand
    attr_reader :wf_case
    def initialize(wf_case)
      @wf_case = wf_case
    end

    def call
      EnableTransitions.call(wf_case)
      done = false
      while done
        done = true
        finished = FinishedP.call(wf_case)
        next unless finished

        ActiveRecord::Base.uncached do
          wf_case.workitems.joins(:transition).where(state: :enabled).where(trigger_type: :automatic).find_each do |item|
            FireTransitionInternal.call(item)
            done = false
          end
        end
        EnableTransitions.call(wf_case)
      end
    end
  end
end
