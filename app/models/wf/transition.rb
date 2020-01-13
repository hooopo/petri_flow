module Wf
  class Transition < ApplicationRecord
    belongs_to :workflow
    has_many :arcs
    has_many :transition_assignments
    has_many :workitems
    belongs_to :formable, optional: true

    enum trigger_type: {
      user: 0,
      automatic: 1,
      message: 2,
      time: 3
    }
  end
end
