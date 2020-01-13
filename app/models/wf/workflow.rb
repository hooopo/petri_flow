module Wf
  class Workflow < ApplicationRecord
    has_many :places
    has_many :transitions
    has_many :arcs
    has_many :transition_assignments
    has_many :cases
    has_many :workitems
    has_many :tokens
  end
end
