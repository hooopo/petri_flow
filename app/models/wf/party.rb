# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_parties
#
#  id            :integer          not null, primary key
#  partable_type :string
#  partable_id   :string
#  party_name    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

module Wf
  class Party < ApplicationRecord
    # TODO: use acts_as_partable for sync group or role or user to party
    belongs_to :partable, polymorphic: true
    has_many :transition_static_assignments
  end
end
