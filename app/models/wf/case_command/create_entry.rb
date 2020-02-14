# frozen_string_literal: true

module Wf::CaseCommand
  class CreateEntry
    prepend SimpleCommand
    attr_reader :form, :workitem, :user, :params
    def initialize(form, workitem, user, params)
      @form       = form
      @workitem   = workitem
      @params     = params
      @user       = user
    end

    def call
      create_entry
    rescue StandardError
      binding.pry
      puts $ERROR_INFO
      # TODO: more detail
      errors.add(:base, :failure)
    end

    def create_entry
      Wf::ApplicationRecord.transaction do
        entry = form.entries.find_or_create_by!(user: user, workitem: workitem)
        params.each do |field_id, field_value|
          if field = entry.field_values.where(form: form, field_id: field_id).first
            field.update!(value: field_value)
          else
            entry.field_values.create!(form: form, field_id: field_id, value: field_value)
          end
        end
        entry.update_payload!
        entry
      end
    end
  end
end
