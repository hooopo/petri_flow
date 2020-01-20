# == Schema Information
#
# Table name: wf_fields
#
#  id              :integer          not null, primary key
#  name            :string
#  form_id         :integer
#  position        :integer          default("0")
#  field_type      :integer          default("0")
#  field_type_name :string
#  default_value   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

module Wf
  class FieldTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
