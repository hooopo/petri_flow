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

      ActiveRecord::Base.transaction do
        AddManualAssignment.call(workitem.case, workitem.transition, party) if permanent

        notified_users = workitem.parties.map do |p|
          p.partable.users.to_a
        end.flatten

        assign = workitem.workitem_assignments.where(party: party).first
        return if assign

        workitem.workitem_assignments.create!(party: party)
        new_users = party.partable.users.to_a
        to_notify = new_users - notified_users
        to_notify.each do |user|
          workitem.transition.notification_callback.constantize.new(workitem, user.id).perform_now
        end
      end
    end
  end
end
