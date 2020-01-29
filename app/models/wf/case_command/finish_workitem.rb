# frozen_string_literal: true

module Wf::CaseCommand
  class FinishWorkitem
    prepend SimpleCommand
    attr_reader :workitem
    def initialize(workitem)
      @workitem = workitem
    end

    def call
      FireTransitionInternal.call(workitem)
      SweepAutomaticTransitions.call(workitem.case)
    end
  end
end
