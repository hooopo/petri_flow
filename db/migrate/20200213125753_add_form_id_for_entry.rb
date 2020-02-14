# frozen_string_literal: true

class AddFormIdForEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :wf_entries, :form_id, :bigint, index: true
  end
end
