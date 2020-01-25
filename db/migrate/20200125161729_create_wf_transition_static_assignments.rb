class CreateWfTransitionStaticAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_transition_static_assignments, comment: 'pre assignment for transition' do |t|
      t.bigint :party_id
      t.bigint :transition_id
      t.bigint :workflow_id
      t.timestamps
    end
    add_index :wf_transition_static_assignments, [:transition_id, :party_id], unique: true, name: 'wf_tp_u'
    drop_table :wf_transition_assignments
  end
end
