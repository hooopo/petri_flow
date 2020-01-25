# frozen_string_literal: true

class CreateWfWorkitemAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_workitem_assignments do |t|
      t.bigint :party_id
      t.bigint :workitem_id
      t.timestamps
    end
    add_index :wf_workitem_assignments, %i[workitem_id party_id], unique: true, name: "wf_wp_u"
  end
end
