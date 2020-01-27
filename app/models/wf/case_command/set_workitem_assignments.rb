# frozen_string_literal: true

module Wf::CaseCommand
  class SetWorkitemAssignments
    prepend SimpleCommand
    attr_reader :workitem
    def initialize(workitem)
      @workitem = workitem
    end

    def call; end
  end
end
