# frozen_string_literal: true

class RemoveUnusedColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :wf_guards, :target_attr_name
  end
end
