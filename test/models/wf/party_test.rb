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

require "test_helper"

module Wf
  class PartyTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
