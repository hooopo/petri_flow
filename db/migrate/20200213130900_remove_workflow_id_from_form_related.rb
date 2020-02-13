# frozen_string_literal: true

class RemoveWorkflowIdFromFormRelated < ActiveRecord::Migration[6.0]
  def change
    remove_column :wf_field_values, :transition_id
    remove_column :wf_field_values, :workflow_id
  end
end
