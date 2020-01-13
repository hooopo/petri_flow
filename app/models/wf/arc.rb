module Wf
  class Arc < ApplicationRecord
    belongs_to :workflow
    belongs_to :transition
    belongs_to :place

    enum direction: {
      in: 0,
      out: 1
    }

    enum arc_type: {
      seq: 0,
      explicit_or_split: 1, 
      implicit_or_split: 2, 
      or_join: 3,
      and_split: 4,
      and_join: 5
    }
  end
end
