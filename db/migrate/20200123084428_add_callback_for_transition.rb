class AddCallbackForTransition < ActiveRecord::Migration[6.0]
  def change
    add_column :wf_transitions, :callback, :string, default: "Wf::Callbacks::Default"
  end
end
