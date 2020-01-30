class InitSomeData < ActiveRecord::Migration[6.0]
  def change
    5.times do |i|
      Wf::Group.create(name: "Group#{i}")
    end

    10.times do |i|
      Wf::User.create(name: "User#{i}", group: Wf::Group.all.sample)
    end
  end
end
