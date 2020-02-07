# frozen_string_literal: true

module Wf
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception
    helper_method :wf_current_user

    breadcrumb "Home", :root_path

    def wf_current_user
      current_user
    end
  end
end
