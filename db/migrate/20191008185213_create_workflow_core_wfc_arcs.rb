class CreateWorkflowCoreWfcArcs < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_arcs do |t|
      t.bigint :workflow_id
      t.bigint :transition_id
      t.bigint :place_id
      t.integer :direction, default: 0, comment: '0-in, 1-out'
      t.integer :arc_type, default: 0, comment: '0-seq,1-explicit_or_split, 2-implicit_or_split, 3-or_join, 4-and_split, 5-and_join'
      # condition only for explicit or split
      t.string :condition_field, comment: 'guard field'
      t.string :condition_op, comment: 'guard operator: >,<,==,'
      t.string :condition_value, comment: 'guard value'
      t.string :condition_exp, comment: 'guard expression'
      t.string :condition_field_type, comment: 'guard field type: Boolean/Integer/Date/String/Float/Datetime'
      t.timestamps
    end
  end
end