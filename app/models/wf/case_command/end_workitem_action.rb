# frozen_string_literal: true

module Wf::CaseCommand
  class EndWorkitemAction
    prepend SimpleCommand
    attr_reader :workitem, :action, :user
    def initialize(workitem, user, action = :start)
      @workitem = workitem
      @action   = action
      @user     = user
    end

    def call
      if action == :start
        StartWorkitem.call(workitem, user)
      elsif action == :finish
        FinishWorkitem.call(workitem, user)
      elsif action == :cancel
        CancelWorkitem.call(workitem, user)
      elsif action == :comment
        raise("Unknown action #{action}")
      end
    end
  end
end
