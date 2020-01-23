# frozen_string_literal: true

class CreateWfFieldValues < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_field_values do |t|
      t.bigint :workflow_id, index: true
      t.bigint :transitiion_id, index: true
      t.bigint :form_id, index: true
      t.bigint :field_id, index: true
      t.text :value
      t.timestamps
    end
  end
end
