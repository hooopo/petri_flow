# == Schema Information
#
# Table name: wf_guards
#
#  id             :integer          not null, primary key
#  arc_id         :integer
#  workflow_id    :integer
#  fieldable_type :string
#  fieldable_id   :string
#  op             :string
#  value          :string
#  exp            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

module Wf
  class GuardTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
