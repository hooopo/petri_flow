class CreateWorkflowCoreWfcTransitionAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_transition_assignments do |t|
      t.bigint :workflow_id
      t.bigint :transition_id
      t.string :assignable_type, comment: 'Assign Type from Application: Group or Role or User etc.'
      t.string :assignable_id, comment: 'Assign ID from Application: group_id or role_id or user_id etc'
      t.timestamps
    end
  end
end
