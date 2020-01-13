class CreateWorkflowCoreWfcTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_transitions do |t|
      t.string :name
      t.text :description
      t.bigint :workflow_id
      t.integer :sort_order, default: 0
      t.integer :trigger_limit, comment: 'use with timed trigger, after x minitues, trigger exec'
      t.integer :trigger_type, default: 0, comment: "0-user,1-automatic, 2-message,3-time"
      t.timestamps
    end
  end
end
