# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_entries
#
#  id          :integer          not null, primary key
#  user_id     :string
#  workitem_id :integer
#  payload     :json             default("{}")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  form_id     :integer
#

require "test_helper"

module Wf
  class EntryTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end
