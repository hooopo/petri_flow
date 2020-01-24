module Wf
  class Group < ApplicationRecord
    has_many :users
    has_one :party, as: :partable
    after_create do
      create_party(party_name: self.name)
    end
  end
end
