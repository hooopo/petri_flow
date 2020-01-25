# frozen_string_literal: true

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
    has_many :places, dependent: :destroy
    has_many :transitions, dependent: :destroy
    has_many :arcs, dependent: :destroy
    has_many :transition_static_assignments
    has_many :cases
    has_many :workitems
    has_many :tokens

    validates :name, presence: true

    def self.enable_callbacks
      [Wf::Callbacks::EnableDefault]
    end

    def self.fire_callbacks
      [Wf::Callbacks::FireDefault]
    end

    def self.assignment_callbacks
      [Wf::Callbacks::AssignmentDefault]
    end

    def self.unassignment_callbacks
      [Wf::Callbacks::UnassignmentDefault]
    end

    def self.notification_callbacks
      [Wf::Callbacks::NotificationDefault]
    end

    def self.deadline_callbacks
      [Wf::Callbacks::DeadlineDefault]
    end

    def self.time_callbacks
      [Wf::Callbacks::TimeDefault]
    end

    def self.hold_timeout_callbacks
      [Wf::Callbacks::HoldTimeoutDefault]
    end

    after_save do
      do_validate!
    end

    after_touch do
      do_validate!
    end

    # TODO: can from start place to end place
    def do_validate!
      msgs = []
      msgs << "must have start place" if places.start.blank?
      msgs << "must have only one start place" if places.start.count > 1
      msgs << "must have end place" if places.end.blank?
      msgs << "must have only one end place" if places.end.count > 1
      msgs << "all transition must have only one arc without guards" if transitions.any? { |t| t.arcs.out.without_guards.count > 1 }
      if msgs.present?
        update_columns(is_valid: false, error_msg: msgs.join("\n"))
      else
        update_columns(is_valid: true, error_msg: "")
      end
    end
  end
end
