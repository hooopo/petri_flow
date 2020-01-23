# frozen_string_literal: true

class CreateWorkflowCoreWfcCases < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_cases do |t|
      t.bigint :workflow_id
      t.string :targetable_type, comment: "point to target type of Application."
      t.string :targetable_id, comment: "point to target ID of Application."
      t.integer :state, default: 0, comment: "0-created, 1-active, 2-suspended, 3-canceled, 4-finished"
      t.timestamps
    end
  end
end
