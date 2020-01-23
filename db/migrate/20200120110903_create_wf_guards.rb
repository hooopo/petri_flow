# frozen_string_literal: true

class CreateWfGuards < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_guards do |t|
      t.bigint :arc_id, index: true
      t.bigint :workflow_id, index: true
      # TODO: guard object & assiginee
      t.string :fieldable_type
      t.string :fieldable_id
      t.string :op
      t.string :value
      t.string :exp

      t.timestamps
    end
    remove_column :wf_arcs, :condition_field
    remove_column :wf_arcs, :condition_op
    remove_column :wf_arcs, :condition_value
    remove_column :wf_arcs, :condition_exp
    remove_column :wf_arcs, :condition_field_type
  end
end
