# == Schema Information
#
# Table name: wf_entries
#
#  id          :integer          not null, primary key
#  user_id     :string
#  workitem_id :integer
#  payload     :json             default("{}")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Wf
  class Entry < ApplicationRecord
    belongs_to :user, class_name: Wf::Workflow.user_class.to_s
    belongs_to :workitem
    has_many :field_values

    def json
      field_values.map {|x| [x.field_id, {field_id: x.id, field_name: x.field.name, value: x.value}]  }.to_h
    end

    def update_payload!
      update(payload: json)
    end
  end
end
