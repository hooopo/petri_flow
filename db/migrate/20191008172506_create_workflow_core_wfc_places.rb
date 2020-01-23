# frozen_string_literal: true

class CreateWorkflowCoreWfcPlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_places do |t|
      t.bigint :workflow_id
      t.string :name
      t.text :description
      t.integer :sort_order, default: 0
      t.integer :place_type, default: 0, comment: "类型：0-normal，1-start，2-end"
      t.timestamps
    end
  end
end
