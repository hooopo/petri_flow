# frozen_string_literal: true

class FixTypo < ActiveRecord::Migration[6.0]
  def change
    rename_column :wf_fields, :positon, :position
  end
end
