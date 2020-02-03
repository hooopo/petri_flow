# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_places
#
#  id          :integer          not null, primary key
#  workflow_id :integer
#  name        :string
#  description :text
#  sort_order  :integer          default("0")
#  place_type  :integer          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Wf
  class Place < ApplicationRecord
    belongs_to :workflow, touch: true
    has_many :arcs
    has_many :tokens
    enum place_type: {
      start: 0,
      normal: 1,
      end: 2
    }
  end
end
