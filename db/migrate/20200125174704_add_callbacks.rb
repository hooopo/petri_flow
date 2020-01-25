# frozen_string_literal: true

class AddCallbacks < ActiveRecord::Migration[6.0]
  def change
    rename_column :wf_transitions, :callback, :enable_callback
    change_column_default :wf_transitions, :enable_callback, "Wf::Callbacks::EnableDefault"
    add_column :wf_transitions, :fire_callback, :string, default: "Wf::Callbacks::FireDefault"
    add_column :wf_transitions, :notification_callback, :string, default: "Wf::Callbacks::NotificationDefault"
    add_column :wf_transitions, :time_callback, :string, default: "Wf::Callbacks::TimeDefault"
    add_column :wf_transitions, :deadline_callback, :string, default: "Wf::Callbacks::DeadlineDefault"
    add_column :wf_transitions, :hold_timeout_callback, :string, default: "Wf::Callbacks::HoldTimeoutDefault"
    add_column :wf_transitions, :assignment_callback, :string, default: "Wf::Callbacks::AssignmentDefault"
    add_column :wf_transitions, :unassignment_callback, :string, default: "Wf::Callbacks::UnassignmentDefault"
  end
end
