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
    has_many :transition_assignments
    has_many :cases
    has_many :workitems
    has_many :tokens

    validates :name, presence: true

    def self.callbacks
      [Wf::Callbacks::Default]
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
