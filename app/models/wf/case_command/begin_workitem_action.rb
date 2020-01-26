# frozen_string_literal: true

module Wf::CaseCommand
  class BeginWorkitemAction
    prepend SimpleCommand
    attr_reader :workitem, :action, :user
    def initialize(workitem, user, action = :start)
      @workitem = workitem
      @action   = action
      @user     = user
    end

    def call
      if action == :start
        raise("Workitem is in state #{workitem.state}, but it must be in state enabled to be started.") unless workitem.enabled?
        raise("You are not assigned to this workitem.") unless workitem.owned_by?(user)
      elsif action == :finish || action == :cancel
        if workitem.started?
          raise("You are not the user currently working on this workitem.") if workitem.holding_user != user
        elsif workitem.enabled?
          raise("You can only cancel a workitem in state started, but this workitem is in state #{workitem.state}.") if action == :cancel
          raise("You are not assigned to this workitem.") unless workitem.owned_by?(user)

          workitem.update!(holding_user: user)
        else
          raise("Workitem is in state #{workitem.state}, but it must be in state enabled or started to be finished.")
        end
      elsif action == :comment
        # TODO
      end
    end
  end
end
