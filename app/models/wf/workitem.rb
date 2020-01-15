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
#  user_type       :string
#  user_id         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module Wf
  class Workitem < ApplicationRecord
    belongs_to :workflow
    belongs_to :transition
    belongs_to :case
    belongs_to :targetable, optional: true
    belongs_to :user, optional: true
    enum state: {
      enabled: 0,
      started: 1,
      canceled: 2,
      finished: 3,
      overridden: 4
    }
  end
end
