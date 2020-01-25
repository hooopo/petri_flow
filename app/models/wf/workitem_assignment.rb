# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_workitem_assignments
#
#  id          :integer          not null, primary key
#  party_id    :integer
#  workitem_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Wf
  class WorkitemAssignment < ApplicationRecord
    belongs_to :party
    belongs_to :workitem
  end
end
