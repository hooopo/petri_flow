require 'active_support/concern'

module Wf
  module ActsAsParty
   extend ActiveSupport::Concern
 
    included do
      has_one :party, as: :partable
    end
 
    module ClassMethods
      def acts_as_party(options = {user: false, party_name: :name})
        cattr_accessor :yaffle_text_field
        self.has_many :users, foreign_key: :id if options[:user]
        self.after_create do
          create_party(party_name: options[:party_name])
        end
      end
    end
  end
end