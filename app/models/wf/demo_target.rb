# == Schema Information
#
# Table name: wf_demo_targets
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module Wf
  class DemoTarget < ApplicationRecord
    has_many :cases, as: :targetable
  end
end
