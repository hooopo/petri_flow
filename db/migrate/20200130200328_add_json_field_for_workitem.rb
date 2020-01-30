# frozen_string_literal: true

class AddJsonFieldForWorkitem < ActiveRecord::Migration[6.0]
  def change
    add_column :wf_workitems, :payload, :json, default: {}, comment: "store user input payload for workitem."
  end
end
