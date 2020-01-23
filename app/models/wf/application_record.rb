# frozen_string_literal: true

module Wf
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
