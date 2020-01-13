module Wf
  class Token < ApplicationRecord
    belongs_to :workflow
    belongs_to :case
    belongs_to :place

    enum state: {
      free: 0, 
      locked: 1, 
      canceled: 2, 
      consumed: 3
    }
  end
end
