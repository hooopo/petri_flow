# == Schema Information
#
# Table name: wf_comments
#
#  id          :integer          not null, primary key
#  workitem_id :integer
#  user_id     :integer
#  body        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# frozen_string_literal: true

require "test_helper"

module Wf
  class CommentTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
