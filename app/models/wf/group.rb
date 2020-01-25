# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Wf
  class Group < ApplicationRecord
    has_many :users
    has_one :party, as: :partable
    after_create do
      create_party(party_name: name)
    end
  end
end
