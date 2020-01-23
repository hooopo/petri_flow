# frozen_string_literal: true

class CreateWfForms < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_forms do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
