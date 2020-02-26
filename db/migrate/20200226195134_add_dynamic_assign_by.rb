# frozen_string_literal: true

class AddDynamicAssignBy < ActiveRecord::Migration[6.0]
  def change
    add_column :wf_transitions, :dynamic_assign_by_id, :bigint, comment: "dynamic assign by other transition", index: true
  end
end
