class CreateWfFields < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_fields do |t|
      t.string :name
      t.bigint :form_id, index: true
      t.integer :positon, default: 0
      t.string :field_type
      t.string :field_type_name
      t.string :default_value
      t.timestamps
    end
  end
end
