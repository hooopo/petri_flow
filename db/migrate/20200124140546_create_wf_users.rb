class CreateWfUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :wf_users, comment: 'For demo' do |t|
      t.string :name
      t.timestamps
    end

    create_table :wf_groups, comment: 'For demo' do |t|
      t.string :name
      t.timestamps
    end

    5.times do |i|
      Wf::Group.create(name: "Group#{i}")
    end

    10.times do |i|
      Wf::User.create(name: "user#{i}")
    end
  end
end
