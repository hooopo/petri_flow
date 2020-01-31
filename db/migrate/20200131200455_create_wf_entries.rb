class CreateWfEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_entries, comment: "user input data for workitem with form." do |t|
      t.string :user_id, index: true
      t.bigint :workitem_id, index: true
      t.json :payload, default: {}
      t.timestamps
    end
    remove_column :wf_workitems, :payload
    add_column :wf_field_values, :entry_id, :bigint, index: true
    add_index :wf_entries, [:workitem_id, :user_id], unique: true
  end
end
