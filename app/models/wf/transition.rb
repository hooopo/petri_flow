# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_transitions
#
#  id                    :integer          not null, primary key
#  name                  :string
#  description           :text
#  workflow_id           :integer
#  sort_order            :integer          default("0")
#  trigger_limit         :integer
#  trigger_type          :integer          default("0")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  form_id               :integer
#  enable_callback       :string           default("Wf::Callbacks::EnableDefault")
#  fire_callback         :string           default("Wf::Callbacks::FireDefault")
#  notification_callback :string           default("Wf::Callbacks::NotificationDefault")
#  time_callback         :string           default("Wf::Callbacks::TimeDefault")
#  deadline_callback     :string           default("Wf::Callbacks::DeadlineDefault")
#  hold_timeout_callback :string           default("Wf::Callbacks::HoldTimeoutDefault")
#  assignment_callback   :string           default("Wf::Callbacks::AssignmentDefault")
#  unassignment_callback :string           default("Wf::Callbacks::UnassignmentDefault")
#  form_type             :string           default("Wf::Form")
#

module Wf
  class Transition < ApplicationRecord
    belongs_to :workflow, touch: true
    has_many :arcs
    has_many :transition_static_assignments
    has_many :static_parties, through: :transition_static_assignments, source: "party"
    has_many :workitems
    belongs_to :form, optional: true, polymorphic: true

    enum trigger_type: {
      user: 0,
      automatic: 1,
      message: 2,
      time: 3
    }

    def explicit_or_split?
      arcs.out.sum(:guards_count) >= 1
    end

    validates :name, presence: true
  end
end
