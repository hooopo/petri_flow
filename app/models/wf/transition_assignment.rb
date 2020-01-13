module Wf
  class TransitionAssignment < ApplicationRecord
    belongs_to :workflow
    belongs_to :transition
    belongs_to :assignable, optional: true
  end
end
