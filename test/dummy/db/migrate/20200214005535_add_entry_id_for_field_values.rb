# frozen_string_literal: true

class AddEntryIdForFieldValues < ActiveRecord::Migration[6.0]
  def change
    add_column :field_values, :entry_id, :bigint, index: true
  end
end
