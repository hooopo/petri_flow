# frozen_string_literal: true

class CreateWorkflowCoreWfcWorkflows < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_workflows do |t|
      t.string :name
      t.text :description
      t.boolean :is_valid, default: false
      t.boolean :is_draft, default: true
      t.bigint :creator_id
      t.text :error_msg
      t.timestamps
    end
  end
end
