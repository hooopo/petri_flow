# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_transition_static_assignments
#
#  id            :integer          not null, primary key
#  party_id      :integer
#  transition_id :integer
#  workflow_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require "test_helper"

module Wf
  class TransitionStaticAssignmentTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
