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

require "test_helper"

module Wf
  class UserTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
