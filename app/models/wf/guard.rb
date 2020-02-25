# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_guards
#
#  id             :integer          not null, primary key
#  arc_id         :integer
#  workflow_id    :integer
#  fieldable_type :string
#  fieldable_id   :string
#  op             :string
#  value          :string
#  exp            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

module Wf
  class Guard < ApplicationRecord
    belongs_to :workflow
    belongs_to :arc, touch: true, counter_cache: true
    belongs_to :fieldable, polymorphic: true, optional: true

    before_validation do
      self.workflow = arc.workflow
    end

    validate :validate_exp_and_fieldable

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
      fieldable&.cast(value)
    end

    def pass?(entry, workitem)
      if exp
        check_exp(entry, workitem)
      else
        check_fieldable(entry)
      end
    end

    def check_exp(entry, workitem)
      # 1000ms, 200mb
      context = MiniRacer::Context.new(timeout: 1000, max_memory: 200_000_000)
      context.eval("let target = #{target_hash.to_json};")
      context.eval("let workitem = #{workitem.to_json};")
      exp_value = context.eval(exp)
      yes_or_no?(exp_value, value)
    end

    def check_fieldable(entry)
      fv = entry.field_values.where(field_id: fieldable_id).first
      return unless fv

      yes_or_no?(fv.value_after_cast, value_after_cast)
    end

    def yes_or_no?(input_value, setting_value)
      if op == "="
        input_value == setting_value
      elsif op == ">"
        input_value > setting_value
      elsif op == "<"
        input_value < setting_value
      elsif op == ">="
        input_value >= setting_value
      elsif op == "<="
        input_value <= setting_value
      elsif op == "is_empty"
        input_value.blank?
      else
        false
      end
    end

    def inspect
      if exp
        %(eval(exp) #{op} #{value})
      else
        %(#{fieldable&.form&.name}.#{fieldable&.name} #{op} #{value})
      end
    end

    def validate_exp_and_fieldable
      if fieldable && exp.present?
        errors.add(:exp, "Exp and Fieldable can not be set at the same time.")
        return
      end

      errors.add(:exp, "Must set one of Exp and Fieldable.") unless fieldable || exp.present?
    end
  end
end
