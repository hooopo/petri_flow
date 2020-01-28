# frozen_string_literal: true

class RemoveWorkitemIdFromToken < ActiveRecord::Migration[6.0]
  def change
    remove_column :wf_tokens, :workitem_id
  end
end
