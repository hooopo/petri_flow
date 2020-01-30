# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class ArcsController < ApplicationController
    def new
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @arc = @workflow.arcs.new
    end

    def create
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @arc = @workflow.arcs.new(arc_params)
      if @arc.save
        redirect_to workflow_path(@workflow), notice: "arc was successfully created."
      else
        render :new
      end
    end

    def destroy
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @arc = @workflow.arcs.find(params[:id])
      @arc.destroy
      render js: "window.location.reload()"
    end

    def show
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @arc = @workflow.arcs.find(params[:id])
    end

    def edit
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @arc = @workflow.arcs.find(params[:id])
    end

    def update
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @arc = @workflow.arcs.find(params[:id])
      if @arc.update(arc_params)
        redirect_to workflow_path(@workflow), notice: "arc was successfully created."
      else
        render :edit
      end
    end

    private

      def arc_params
        params.fetch(:arc, {}).permit(:direction, :transition_id, :place_id)
      end
  end
end
