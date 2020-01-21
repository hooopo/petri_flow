module Wf
  class DemoTarget < ApplicationRecord
    has_many :cases, as: :targetable
  end
end
