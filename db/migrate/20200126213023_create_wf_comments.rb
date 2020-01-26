# frozen_string_literal: true

class CreateWfComments < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_comments do |t|
      t.bigint :workitem_id, index: true
      t.bigint :user_id, index: true
      t.text :body
      t.timestamps
    end
  end
end
