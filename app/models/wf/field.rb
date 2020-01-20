# == Schema Information
#
# Table name: wf_fields
#
#  id              :integer          not null, primary key
#  name            :string
#  form_id         :integer
#  position        :integer          default("0")
#  field_type      :integer          default("0")
#  field_type_name :string
#  default_value   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module Wf
  class Field < ApplicationRecord
    belongs_to :form

    enum field_type: {
      text: 0,
      int8: 1,
      boolean: 2,
      timestamp: 3,
      float: 4,
      date: 5,
      tsrange: 10,
      daterange: 11,
      numrange: 12,
      int8range: 13,
      "text[]": 20,
      "int8[]": 21,
      "timestamp[]": 23,
      "float[]": 24,
      "date[]": 25,
    }
  end
end
