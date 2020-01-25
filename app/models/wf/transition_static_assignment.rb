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
  end
end
