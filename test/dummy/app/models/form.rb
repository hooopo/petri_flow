# frozen_string_literal: true

# == Schema Information
#
# Table name: wf_forms
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Form < ApplicationRecord
  has_many :fields, dependent: :destroy
  has_many :entries
end
