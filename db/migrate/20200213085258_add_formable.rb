# frozen_string_literal: true

class AddFormable < ActiveRecord::Migration[6.0]
  def change
    add_column :wf_transitions, :form_type, :string, default: "Wf::Form"
    add_index :wf_transitions, %i[form_type form_id]
  end
end
