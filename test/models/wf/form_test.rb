# == Schema Information
#
# Table name: wf_forms
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

module Wf
  class FormTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
