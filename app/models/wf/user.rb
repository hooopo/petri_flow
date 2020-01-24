module Wf
  class User < ApplicationRecord
    belongs_to :group, optional: true
    has_one :party, as: :partable

    after_create do
      create_party(party_name: self.name)
    end
  end
end
