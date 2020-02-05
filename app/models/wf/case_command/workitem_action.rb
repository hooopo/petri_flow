# frozen_string_literal: true

module Wf::CaseCommand
  class WorkitemAction
    prepend SimpleCommand
    attr_reader :workitem, :action, :user
    def initialize(workitem, user, action = :start)
      @workitem = workitem
      @action   = action
      @user     = user
    end

    def call
      ActiveRecord::Base.transaction do
        BeginWorkitemAction.call(workitem, user, action)
        EndWorkitemAction.call(workitem, user, action)
      end
    end
  end
end
