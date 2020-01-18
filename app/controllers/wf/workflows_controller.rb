require_dependency "wf/application_controller"

module Wf
  class WorkflowsController < ApplicationController
    def index 
      @workflows = Wf::Workflow.order('id DESC').page(params[:page])
    end

    def new
      @workflow = Wf::Workflow.new
    end

    def edit
      @workflow = Wf::Workflow.find(params[:id])
    end

    def show
      @workflow = Wf::Workflow.find(params[:id])
    end

    def update
      @workflow = Wf::Workflow.find(params[:id])
      if @workflow.update(workflow_params)
        redirect_to workflow_path(@workflow), notice: "workflow was successfully updated."
      else
        render :edit
      end
    end

    def create
      @workflow = Workflow.new(workflow_params)

      if @workflow.save
        redirect_to workflows_path, notice: "workflow was successfully created."
      else
        render :new
      end
    end

    private

    def workflow_params
      params.fetch(:workflow, {}).permit(:name, :description)
    end
  end
end
