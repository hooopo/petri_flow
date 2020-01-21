class AddGuardsCountForArc < ActiveRecord::Migration[6.0]
  def change
    add_column :wf_arcs, :guards_count, :integer, default: 0
  end
end
