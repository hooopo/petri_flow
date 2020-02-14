# frozen_string_literal: true

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
    belongs_to :form, touch: true

    enum field_type: {
      string: 0,
      integer: 1,
      boolean: 2,
      date: 3,
      datetime: 4,
      decimal: 5,
      float: 6,
      json: 7,
      text: 8,

      "string[]": 20,
      "integer[]": 21,
      "date[]": 23,
      "datetime[]": 24,
      "decimal[]": 25,
      "float[]": 26,
      "json[]": 27,
      "text[]": 28
    }

    # TODO: array type
    def field_type_for_view
      case field_type
      when "string"
        "text_field"
      when "integer"
        "number_field"
      when "date"
        "date_field"
      when "datetime"
        "datetime_field"
      when "boolean"
        "radio_button"
      when "text"
        "text_area"
      else
        "text_field"
      end
    end

    def array?
      field_type.to_s.match(/^(\w+)(\[\])?$/)[2] == "[]"
    end

    def type_for_cast
      type = field_type.to_s.match(/^(\w+)(\[\])?$/)[1]
      if array?
        ActiveRecord::Type.lookup(type.to_sym, adapter: :postgresql, array: true)
      else
        ActiveRecord::Type.lookup(type.to_sym, adapter: :postgresql)
      end
    end

    delegate :cast, to: :type_for_cast
  end
end
