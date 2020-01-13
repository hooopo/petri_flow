module Wf
  class Case < ApplicationRecord
    belongs_to :workflow
    belongs_to :targetable, optional: true
    has_many :workitems
    has_many :tokens

    enum state: {
      created: 0,
      active: 1,
      suspended: 2,
      canceled: 3,
      finished: 4
    }
  end
end
