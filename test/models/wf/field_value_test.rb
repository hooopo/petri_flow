# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_field_values
#
#  id            :integer          not null, primary key
#  workflow_id   :integer
#  transition_id :integer
#  form_id       :integer
#  field_id      :integer
#  value         :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require "test_helper"

module Wf
  class FieldValueTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
