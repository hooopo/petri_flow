# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :integer
#

module Wf
  class User < ApplicationRecord
    belongs_to :group, optional: true
    include Wf::ActsAsParty
    acts_as_party(user: true, party_name: :name)
  end
end
