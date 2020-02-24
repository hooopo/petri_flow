# frozen_string_literal: true

module Wf::CaseCommand
  class AddWorkitemAssignment
    prepend SimpleCommand
    attr_reader :workitem, :party, :permanent
    def initialize(workitem, party, permanent = true)
      @workitem = workitem
      @party    = party
      @permanent = permanent
    end

    def call
      return if party.nil?

      Wf::ApplicationRecord.transaction do
        AddManualAssignment.call(workitem.case, workitem.transition, party) if permanent

        notified_users = workitem.parties.map do |p|
          p.partable.users.to_a
        end.flatten

        assign = workitem.workitem_assignments.where(party: party).first
        break if assign

        workitem.workitem_assignments.create!(party: party)
        new_users = party.partable.users.to_a
        to_notify = new_users - notified_users
        transition = workitem.transition
        to_notify.each do |user|
          # TODO: multiple instance + sub workflow
          if transition.multiple_instance? && !workitem.forked?
            next if workitem.children.where(holding_user: user).exists?

            child = workitem.children.create!(
              workflow_id: workitem.workflow_id,
              transition_id: workitem.transition_id,
              state: :enabled,
              trigger_time: workitem.trigger_time,
              forked: true,
              holding_user: user,
              case_id: workitem.case_id
            )
            workitem.transition.notification_callback.constantize.new(child, user.id).perform_now
          else
            workitem.transition.notification_callback.constantize.new(workitem, user.id).perform_now
          end
        end
      end
    end
  end
end
