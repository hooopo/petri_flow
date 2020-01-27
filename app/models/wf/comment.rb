# frozen_string_literal: true
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

module Wf
  class Comment < ApplicationRecord
    belongs_to :workitem
    belongs_to :user, class_name: Wf::Workflow.user_class
  end
end
