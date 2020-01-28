# frozen_string_literal: true

module Wf
  module ApplicationHelper
    def current_user
      Wf::User.first
    end
  end
end
