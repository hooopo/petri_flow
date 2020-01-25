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
#  holding_user_id :integer
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

    enum state: {
      enabled: 0,
      started: 1,
      canceled: 2,
      finished: 3,
      overridden: 4
    }

    # TODO: check payload && guards exp
    def pass_guard?(arc)
      return true if arc.guards_count == 0

      true
    end
  end
end
