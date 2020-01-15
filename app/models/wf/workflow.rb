# == Schema Information
#
# Table name: wf_workflows
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  is_valid    :boolean          default("false")
#  is_draft    :boolean          default("true")
#  creator_id  :integer
#  error_msg   :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Wf
  class Workflow < ApplicationRecord
    has_many :places
    has_many :transitions
    has_many :arcs
    has_many :transition_assignments
    has_many :cases
    has_many :workitems
    has_many :tokens
  end
end
