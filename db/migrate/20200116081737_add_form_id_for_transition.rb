class AddFormIdForTransition < ActiveRecord::Migration[6.0]
  def change
    add_column :wf_transitions, :form_id, :bigint, index: true
  end
end
