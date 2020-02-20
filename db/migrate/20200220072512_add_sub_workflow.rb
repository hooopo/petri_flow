# frozen_string_literal: true

class AddSubWorkflow < ActiveRecord::Migration[6.0]
  def change
    add_column :wf_transitions, :sub_workflow_id, :bigint, index: true
    add_column :wf_cases, :started_by_workitem_id, :bigint, index: true, comment: "As a sub workflow instance, it is started by one workitem."
  end
end
