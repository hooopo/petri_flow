# frozen_string_literal: true
# == Schema Information
#
# Table name: wf_case_assignments
#
#  id            :integer          not null, primary key
#  case_id       :integer
#  transition_id :integer
#  party_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# frozen_string_literal: true

module Wf
  class CaseAssignment < ApplicationRecord
    belongs_to :case
    belongs_to :transition
    belongs_to :party
  end
end
