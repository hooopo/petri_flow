# frozen_string_literal: true

class CreateWfParties < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_parties, comment: "for groups or roles or users or positions etc." do |t|
      t.string :partable_type
      t.string :partable_id
      t.string :party_name
      t.timestamps
    end
    add_index :wf_parties, %i[partable_type partable_id], unique: true
  end
end
