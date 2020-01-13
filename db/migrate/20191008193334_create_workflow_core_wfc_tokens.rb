class CreateWorkflowCoreWfcTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_tokens do |t|
      t.bigint :workflow_id
      t.bigint :case_id
      t.string :targetable_type
      t.string :targetable_id
      t.bigint :place_id
      t.integer :state, default: 0, comment: "0-free, 1-locked, 2-canceled, 3-consumed"
      t.bigint :workitem_id
      t.bigint :locked_workitem_id
      t.datetime :produced_at, default: -> { "timezone('utc'::text, now())" }
      t.datetime :locked_at
      t.datetime :canceled_at
      t.datetime :consumed_at
      t.timestamps
    end
  end
end
