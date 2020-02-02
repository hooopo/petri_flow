# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_workitems
#
#  id              :integer          not null, primary key
#  case_id         :integer
#  workflow_id     :integer
#  transition_id   :integer
#  targetable_type :string
#  targetable_id   :string
#  state           :integer          default("0")
#  enabled_at      :datetime
#  started_at      :datetime
#  canceled_at     :datetime
#  finished_at     :datetime
#  overridden_at   :datetime
#  deadline        :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  trigger_time    :datetime
#  holding_user_id :string
#

module Wf
  class Workitem < ApplicationRecord
    belongs_to :workflow
    belongs_to :transition
    belongs_to :case
    belongs_to :targetable, optional: true
    belongs_to :holding_user, foreign_key: :holding_user_id, class_name: Workflow.user_class.to_s, optional: true
    has_many :workitem_assignments
    has_many :parties, through: :workitem_assignments, source: "party"
    has_many :comments
    has_many :entries

    enum state: {
      enabled: 0,
      started: 1,
      canceled: 2,
      finished: 3,
      overridden: 4
    }

    def name
      "Workitem -> #{id}"
    end

    # TODO: guards exp && target guards
    def pass_guard?(arc, has_passed = false)
      if arc.guards_count == 0
        !has_passed
      else
        entry = entries.where(user: holding_user).first
        arc.guards.all? { |guard| guard.pass?(entry) }
      end
    end

    def started_by?(user)
      enabled? && owned_by?(user)
    end

    def finished_by?(user)
      started? && owned_by?(user) && holding_user == user
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
