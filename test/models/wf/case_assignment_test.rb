# == Schema Information
#
# Table name: wf_case_assignments
#
#  id            :integer          not null, primary key
#  case_id       :integer
#  transition_id :integer
#  party_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# frozen_string_literal: true

require "test_helper"

module Wf
  class CaseAssignmentTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
