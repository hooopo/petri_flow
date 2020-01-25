module Wf
  class TransitionStaticAssignment < ApplicationRecord
    belongs_to :workflow
    belongs_to :transition
    belongs_to :party
  end
end
