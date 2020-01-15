# == Schema Information
#
# Table name: wf_cases
#
#  id              :integer          not null, primary key
#  workflow_id     :integer
#  targetable_type :string
#  targetable_id   :string
#  state           :integer          default("0")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module Wf
  class Case < ApplicationRecord
    belongs_to :workflow
    belongs_to :targetable, optional: true
    has_many :workitems
    has_many :tokens

    enum state: {
      created: 0,
      active: 1,
      suspended: 2,
      canceled: 3,
      finished: 4
    }
  end
end
