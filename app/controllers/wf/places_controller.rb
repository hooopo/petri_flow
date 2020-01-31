# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class PlacesController < ApplicationController
    breadcrumb "Workflows", :workflows_path
    def new
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @place = @workflow.places.new
      breadcrumb @workflow.name, workflow_path(@workflow)
    end

    def create
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @place = @workflow.places.new(place_params)
      if @place.save
        redirect_to workflow_path(@workflow), notice: "place was successfully created."
      else
        render :new
      end
    end

    def destroy
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @place = @workflow.places.find(params[:id])
      @place.destroy
      render js: "window.location.reload()"
    end

    def edit
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @place = @workflow.places.find(params[:id])
      breadcrumb @workflow.name, workflow_path(@workflow)
    end

    def update
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @place = @workflow.places.find(params[:id])
      if @place.update(place_params)
        redirect_to workflow_path(@workflow), notice: "place was successfully created."
      else
        render :edit
      end
    end

    private

      def place_params
        params.fetch(:place, {}).permit(:name, :description, :place_type, :sort_order)
      end
  end
end
