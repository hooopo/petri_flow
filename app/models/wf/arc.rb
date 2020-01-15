# == Schema Information
#
# Table name: wf_arcs
#
#  id                   :integer          not null, primary key
#  workflow_id          :integer
#  transition_id        :integer
#  place_id             :integer
#  direction            :integer          default("0")
#  arc_type             :integer          default("0")
#  condition_field      :string
#  condition_op         :string
#  condition_value      :string
#  condition_exp        :string
#  condition_field_type :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

module Wf
  class Arc < ApplicationRecord
    belongs_to :workflow
    belongs_to :transition
    belongs_to :place

    enum direction: {
      in: 0,
      out: 1
    }

    enum arc_type: {
      seq: 0,
      explicit_or_split: 1, 
      implicit_or_split: 2, 
      or_join: 3,
      and_split: 4,
      and_join: 5
    }
  end
end
