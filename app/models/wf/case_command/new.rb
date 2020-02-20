# frozen_string_literal: true

module Wf::CaseCommand
  class New
    prepend SimpleCommand
    attr_reader :workflow, :target, :started_by
    def initialize(workflow, target = nil, started_by = nil)
      @workflow = workflow
      @target = target
      @started_by = started_by
    end

    def call
      wf_case = workflow.cases.create!(targetable: target, started_by_workitem: started_by, state: :created)
      wf_case
    end
  end
end
