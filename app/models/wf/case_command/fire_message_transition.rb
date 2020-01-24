# frozen_string_literal: true

module Wf::CaseCommand
  class FireMessageTransition
    prepend SimpleCommand
    attr_reader :workitem
    def initialize(workitem)
      @workitem = workitem
    end

    def call
      raise("Transition #{workitem.transition.name} is not message triggered") unless workitem.transition.message?

      FireTransitionInternal.call(workitem)
      SweepAutomaticTransitions.call(workitem.case)
    end
  end
end
