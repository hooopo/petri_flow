# frozen_string_literal: true

class ChangeWorkitemHoldingUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :wf_workitems, :user_id
    remove_column :wf_workitems, :user_type
    add_column :wf_workitems, :holding_user, :bigint, comment: "id of app user", index: true
  end
end
