# frozen_string_literal: true

class RenameHoldingUserToHoldingUserId < ActiveRecord::Migration[6.0]
  def change
    rename_column :wf_workitems, :holding_user, :holding_user_id
  end
end
