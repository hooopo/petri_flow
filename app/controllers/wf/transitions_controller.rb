# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class TransitionsController < ApplicationController
    breadcrumb "Workflows", :workflows_path

    def new
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @transition = @workflow.transitions.new
      breadcrumb @workflow.name, workflow_path(@workflow)
    end

    def create
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @transition = @workflow.transitions.new(transition_params)
      if @transition.save
        redirect_to workflow_path(@workflow), notice: "transition was successfully created."
      else
        render :new
      end
    end

    def edit
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @transition = @workflow.transitions.find(params[:id])
      breadcrumb @workflow.name, workflow_path(@workflow)
    end

    def destroy
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @transition = @workflow.transitions.find(params[:id])
      @transition.destroy
      render js: "window.location.reload()"
    end

    def update
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @transition = @workflow.transitions.find(params[:id])
      if @transition.update(transition_params)
        redirect_to workflow_path(@workflow), notice: "transition was successfully updated."
      else
        render :edit
      end
    end

    private

      def transition_params
        params.fetch(:transition, {}).permit(
          :name,
          :description,
          :trigger_limit,
          :trigger_type,
          :sort_order,
          :form_id,
          :enable_callback,
          :fire_callback,
          :time_callback,
          :hold_timeout_callback,
          :assignment_callback,
          :unassignment_callback,
          :notification_callback,
          :deadline_callback
        )
      end
  end
end
