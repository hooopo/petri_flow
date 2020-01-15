# == Schema Information
#
# Table name: wf_tokens
#
#  id                 :integer          not null, primary key
#  workflow_id        :integer
#  case_id            :integer
#  targetable_type    :string
#  targetable_id      :string
#  place_id           :integer
#  state              :integer          default("0")
#  workitem_id        :integer
#  locked_workitem_id :integer
#  produced_at        :datetime
#  locked_at          :datetime
#  canceled_at        :datetime
#  consumed_at        :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

module Wf
  class Token < ApplicationRecord
    belongs_to :workflow
    belongs_to :case
    belongs_to :place

    enum state: {
      free: 0, 
      locked: 1, 
      canceled: 2, 
      consumed: 3
    }
  end
end
