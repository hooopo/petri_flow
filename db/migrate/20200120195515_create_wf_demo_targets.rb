class CreateWfDemoTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_demo_targets, comment: 'For demo, useless.' do |t|
      t.string :name
      t.string :description
      t.timestamps
    end
    1..10.times do |i|
      Wf::DemoTarget.create(name: "name#{i}", description: "description#{i}")
    end
  end
end
