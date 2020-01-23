# == Schema Information
#
# Table name: wf_transitions
#
#  id            :integer          not null, primary key
#  name          :string
#  description   :text
#  workflow_id   :integer
#  sort_order    :integer          default("0")
#  trigger_limit :integer
#  trigger_type  :integer          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  form_id       :integer
#  callback      :string           default("Wf::Callbacks::Default")
#

module Wf
  class Transition < ApplicationRecord
    belongs_to :workflow, touch: true
    has_many :arcs
    has_many :transition_assignments
    has_many :workitems
    belongs_to :form, optional: true

    enum trigger_type: {
      user: 0,
      automatic: 1,
      message: 2,
      time: 3
    }

    validates :name, presence: true
  end
end
