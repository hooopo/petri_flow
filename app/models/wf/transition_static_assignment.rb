# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_transition_static_assignments
#
#  id            :integer          not null, primary key
#  party_id      :integer
#  transition_id :integer
#  workflow_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

module Wf
  class TransitionStaticAssignment < ApplicationRecord
    belongs_to :workflow
    belongs_to :transition
    belongs_to :party

    validates :party_id, uniqueness: { scope: %i[workflow_id transition_id] }

    before_validation do
      self.workflow_id = transition&.workflow_id
    end
  end
end
