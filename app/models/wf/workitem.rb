# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_workitems
#
#  id                      :integer          not null, primary key
#  case_id                 :integer
#  workflow_id             :integer
#  transition_id           :integer
#  state                   :integer          default("0")
#  enabled_at              :datetime
#  started_at              :datetime
#  canceled_at             :datetime
#  finished_at             :datetime
#  overridden_at           :datetime
#  deadline                :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  trigger_time            :datetime
#  holding_user_id         :string
#  children_count          :integer          default("0")
#  children_finished_count :integer          default("0")
#  forked                  :boolean          default("false")
#  parent_id               :integer
#

module Wf
  class Workitem < ApplicationRecord
    belongs_to :workflow
    belongs_to :transition
    belongs_to :case
    belongs_to :parent, class_name: "Wf::Workitem", optional: true, counter_cache: :children_count
    belongs_to :holding_user, foreign_key: :holding_user_id, class_name: Wf.user_class.to_s, optional: true
    has_many :workitem_assignments
    has_many :parties, through: :workitem_assignments, source: "party"
    has_many :comments
    has_many :entries, class_name: Wf.entry_class.to_s
    has_one :started_case, foreign_key: :started_by_workitem_id, class_name: "Wf::Case"

    has_many :children, foreign_key: :parent_id, class_name: "Wf::Workitem"

    enum state: {
      enabled: 0,
      started: 1,
      canceled: 2,
      finished: 3,
      overridden: 4
    }

    def self.todo(wf_current_user)
      current_party_ids = [
        wf_current_user,
        Wf.org_classes.map { |org, _org_class| wf_current_user&.public_send(org) }
      ].flatten.map { |x| x&.party&.id }.compact
      Wf::Workitem.where(forked: false).joins(:workitem_assignments).where(Wf::WorkitemAssignment.table_name => { party_id: current_party_ids })
    end

    def self.doing(wf_current_user)
      where(holding_user: wf_current_user).where(state: [:started, :enabled])
    end

    def self.done(wf_current_user)
      where(holding_user: wf_current_user).where(state: [:finished])
    end

    def parent?
      !forked
    end

    def name
      "Workitem -> #{id}"
    end

    def pass_guard?(arc, has_passed = false)
      if arc.guards_count == 0
        !has_passed
      else
        entry = entries.where(user: holding_user).first
        arc.guards.all? { |guard| guard.pass?(entry, self) }
      end
    end

    def real?
      return false if transition.multiple_instance? && parent_id.nil?
      return false if transition.sub_workflow_id.present?

      true
    end

    def started_by?(user)
      real? && enabled? && owned_by?(user)
    end

    def finished_by?(user)
      real? && started? && owned_by?(user) && holding_user == user
    end

    def owned_by?(user)
      Wf::Party.joins(workitem_assignments: { workitem: %i[transition case] })
               .where(Wf::Transition.table_name => { trigger_type: Wf::Transition.trigger_types[:user] })
               .where(Wf::Case.table_name => { state: Wf::Case.states[:active] })
               .where(Wf::Workitem.table_name => { state: Wf::Workitem.states.values_at(:started, :enabled) })
               .where(Wf::Workitem.table_name => { id: id }).map do |party|
        party.partable.users.to_a
      end.flatten.include?(user)
    end
  end
end
