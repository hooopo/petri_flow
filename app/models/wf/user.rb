# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module Wf
  class User < ApplicationRecord
    belongs_to :group, optional: true
    has_one :party, as: :partable

    after_create do
      create_party(party_name: name)
    end
  end
end
