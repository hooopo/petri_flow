# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class StaticAssignmentsController < ApplicationController
    def new
      @transition = Wf::Transition.find(params[:transition_id])
      @static_assignment = @transition.transition_static_assignments.new
    end

    def create
      @transition = Wf::Transition.find(params[:transition_id])
      @party = Wf::Party.find(permit_params[:party_id])
      @static_assignment = @transition.transition_static_assignments.new(party: @party)
      if @static_assignment.save
        redirect_to workflow_transition_path(@transition.workflow, @transition), notice: "static assignment was successfully created."
      else
        render :new
      end
    end

    def destroy
      @transition = Wf::Transition.find(params[:transition_id])
      @static_assignment = @transition.transition_static_assignments.find(params[:id])
      @static_assignment.destroy
      render js: "window.location.reload()"
    end

    def permit_params
      params.fetch(:transition_static_assignment, {}).permit(:party_id)
    end
  end
end
