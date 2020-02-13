# frozen_string_literal: true

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

class Entry < ApplicationRecord
  belongs_to :form
  belongs_to :user, class_name: Wf::Workflow.user_class.to_s
  belongs_to :workitem, class_name: "Wf::Workitem"
  has_many :field_values

  after_initialize do
    self.payload = {} if payload.blank?
  end

  def json
    field_values.includes(:field).map { |x| [x.field_id.to_i, { field_id: x.id.to_i, field_name: x.field.name, value: x.value_after_cast }] }.to_h
  end

  def update_payload!
    update(payload: json)
  end
end
