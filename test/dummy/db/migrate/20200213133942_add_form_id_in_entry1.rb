# frozen_string_literal: true

class AddFormIdInEntry1 < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :form_id, :bigint, index: true
  end
end
