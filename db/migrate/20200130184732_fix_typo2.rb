# frozen_string_literal: true

class FixTypo2 < ActiveRecord::Migration[6.0]
  def change
    rename_column :wf_field_values, :transitiion_id, :transition_id
  end
end
