class CreateWorkflowCoreWfcWorkitems < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_workitems do |t|
      t.bigint :case_id
      t.bigint :workflow_id
      t.bigint :transition_id
      t.string :targetable_type, comment: 'point to type of Application target: Task or Issue or PullRequest or Project etc.'
      t.string :targetable_id, comment: 'point to id of Application target: task_id or issue_id or pull_request_id or project_id etc.'
      t.integer :state, default: 0, comment: "0-enabled, 1-started, 2-canceled, 3-finished,4-overridden"
      t.datetime :enabled_at, default: -> { "timezone('utc'::text, now())" }
      t.datetime :started_at
      t.datetime :canceled_at
      t.datetime :finished_at
      t.datetime :overridden_at
      t.datetime :deadline, comment: "set when transition_trigger=TIME"
      t.string :user_type, comment: "point to type of Application user: User or Member or Account etc."
      t.string :user_id, comment: "point to type fo Application user id: user_id or member_id or account_id etc."
      t.timestamps
    end
  end
end
