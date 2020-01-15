# == Schema Information
#
# Table name: wf_transition_assignments
#
#  id              :integer          not null, primary key
#  workflow_id     :integer
#  transition_id   :integer
#  assignable_type :string
#  assignable_id   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module Wf
  class TransitionAssignment < ApplicationRecord
    belongs_to :workflow
    belongs_to :transition
    belongs_to :assignable, optional: true
  end
end
