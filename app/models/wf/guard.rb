# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_guards
#
#  id               :integer          not null, primary key
#  arc_id           :integer
#  workflow_id      :integer
#  fieldable_type   :string
#  fieldable_id     :string
#  op               :string
#  value            :string
#  exp              :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  target_attr_name :string
#

module Wf
  class Guard < ApplicationRecord
    belongs_to :workflow
    belongs_to :arc, touch: true, counter_cache: true
    belongs_to :fieldable, polymorphic: true, optional: true

    before_validation do
      self.workflow = arc.workflow
    end

    OP = %w[
      =
      >
      <
      >=
      <=
      is_empty
    ].freeze

    def value_after_cast
      field = fieldable
      if fieldable
        fieldable.type_for_cast.cast(value)
      else
        # TODO
      end
    end

    def pass?(entry)
      fv = entry.field_values.where(field_id: fieldable_id).first
      return unless fv

      if op == "="
        fv.value_after_cast == value_after_cast
      elsif op == ">"
        fv.value_after_cast > value_after_cast
      elsif op == "<"
        fv.value_after_cast < value_after_cast
      elsif op == ">="
        fv.value_after_cast >= value_after_cast
      elsif op == "<="
        fv.value_after_cast <= value_after_cast
      elsif op == "is_empty"
        fv.value_after_cast.blank?
      else
        false
      end
    end

    def inspect
      %(#{fieldable&.form&.name}.#{fieldable&.name} #{op} #{value})
    end
  end
end
