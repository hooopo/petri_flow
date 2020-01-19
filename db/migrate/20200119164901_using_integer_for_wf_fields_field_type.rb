class UsingIntegerForWfFieldsFieldType < ActiveRecord::Migration[6.0]
  def change
    change_column :wf_fields, :field_type, :integer, default: 0, using: "field_type::integer"
  end
end
