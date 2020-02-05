# frozen_string_literal: true

module Wf::CaseCommand
  class StartWorkitem
    prepend SimpleCommand
    attr_reader :workitem, :user
    def initialize(workitem, user)
      @workitem = workitem
      @user     = user
    end

    def call
      raise("The workitem is not in state #{workitem.state}") unless workitem.enabled?

      # TODO: holding timeout
      ActiveRecord::Base.transaction do
        workitem.update!(state: :started, holding_user: user)

        workitem.transition.arcs.in.each do |arc|
          LockToken.call(workitem.case, arc.place, workitem)
        end
      end
      workitem
    end
  end
end
