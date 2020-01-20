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
    belongs_to :arc
    belongs_to :fieldable, polymorphic: true, optional: true

    OP = %w[
      =
      >
      <
      >=
      <=
    ]

    def inspect
      %Q{#{fieldable&.form&.name}.#{fieldable&.name} #{op} #{value}}
    end
  end
end
