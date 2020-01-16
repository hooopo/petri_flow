# == Schema Information
#
# Table name: wf_fields
#
#  id              :integer          not null, primary key
#  name            :string
#  form_id         :integer
#  positon         :integer          default("0")
#  field_type      :string
#  field_type_name :string
#  default_value   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module Wf
  class Field < ApplicationRecord
    belongs_to :form
  end
end
