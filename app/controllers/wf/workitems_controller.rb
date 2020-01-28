# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class WorkitemsController < ApplicationController
    def show
      @workitem = Wf::Workitem.find(params[:id])
    end
  end
end
