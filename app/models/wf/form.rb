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

module Wf
  class Form < ApplicationRecord
    has_many :fields, dependent: :destroy
  end
end
