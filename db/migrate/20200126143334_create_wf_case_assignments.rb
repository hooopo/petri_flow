# frozen_string_literal: true

class CreateWfCaseAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_case_assignments, comment: "Manual per-case assignments of transition to parties" do |t|
      t.bigint :case_id
      t.bigint :transition_id
      t.bigint :party_id
      t.timestamps
    end
    add_index :wf_case_assignments, %i[case_id transition_id party_id], unique: true, name: "wf_ctp_u"
  end
end
