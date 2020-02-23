# frozen_string_literal: true

class AddMultiInstance < ActiveRecord::Migration[6.0]
  def change
    add_column :wf_transitions, :multiple_instance, :boolean, default: false, comment: "multiple instance mode or not"
    add_column :wf_transitions, :finish_condition, :string, comment: "set finish condition for parent workitem.", default: "Wf::MultipleInstances::AllFinish"
    add_column :wf_workitems, :children_count, :integer, default: 0
    add_column :wf_workitems, :children_finished_count, :integer, default: 0
    add_column :wf_workitems, :forked, :boolean, default: false
    add_column :wf_workitems, :parent_id, :bigint, comment: "parent workitem id"
  end
end
