# frozen_string_literal: true

class RemoveTargetableFromWorkitem < ActiveRecord::Migration[6.0]
  def change
    remove_column :wf_workitems, :targetable_id
    remove_column :wf_workitems, :targetable_type
  end
end
