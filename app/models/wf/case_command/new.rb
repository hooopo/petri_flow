# frozen_string_literal: true

module Wf::CaseCommand
  class New
    prepend SimpleCommand
    attr_reader :workflow, :target
    def initialize(workflow, target = nil)
      @workflow = workflow
      @target = target
    end

    def call
      wf_case = workflow.cases.create(targetable: target, state: :created)
    end
  end
end
