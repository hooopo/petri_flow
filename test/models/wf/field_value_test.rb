# frozen_string_literal: true
# == Schema Information
#
# Table name: wf_field_values
#
#  id         :integer          not null, primary key
#  form_id    :integer
#  field_id   :integer
#  value      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  entry_id   :integer
#

require "test_helper"

module Wf
  class FieldValueTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
