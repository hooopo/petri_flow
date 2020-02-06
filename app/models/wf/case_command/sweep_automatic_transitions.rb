# frozen_string_literal: true

module Wf::CaseCommand
  class SweepAutomaticTransitions
    prepend SimpleCommand
    attr_reader :wf_case
    def initialize(wf_case)
      @wf_case = wf_case
    end

    def call
      Wf::ApplicationRecord.transaction do
        EnableTransitions.call(wf_case)
        done = false
        until done
          done = true
          finished = FinishedP.call(wf_case).result
          next if finished

          Wf::ApplicationRecord.uncached do
            wf_case.workitems.joins(:transition).where(state: :enabled).where(Wf::Transition.table_name => { trigger_type: Wf::Transition.trigger_types[:automatic] }).find_each do |item|
              FireTransitionInternal.call(item)
              done = false
            end
          end
          EnableTransitions.call(wf_case)
        end
      end
    end
  end
end
