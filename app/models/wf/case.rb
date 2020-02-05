# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_cases
#
#  id              :integer          not null, primary key
#  workflow_id     :integer
#  targetable_type :string
#  targetable_id   :string
#  state           :integer          default("0")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module Wf
  class Case < ApplicationRecord
    belongs_to :workflow
    belongs_to :targetable, optional: true, polymorphic: true
    has_many :workitems
    has_many :tokens
    has_many :case_assignments
    has_many :parties, through: :case_assignments, source: "party"

    enum state: {
      created: 0,
      active: 1,
      suspended: 2,
      canceled: 3,
      finished: 4
    }

    def can_fire?(transition)
      ins = transition.arcs.in.to_a
      return false if ins.blank?

      ins.all? { |arc| arc.place.tokens.where(case: self).where(state: :free).exists? }
    end

    def name
      "Case->#{id}"
    end
  end
end
