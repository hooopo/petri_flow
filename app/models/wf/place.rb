module Wf
  class Place < ApplicationRecord
    belongs_to :workflow
    has_many :arcs
    has_many :tokens
    enum place_type: {
      normal: 0,
      start: 1,
      end: 2
    }
  end
end
