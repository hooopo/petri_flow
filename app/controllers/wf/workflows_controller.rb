require_dependency "wf/application_controller"

module Wf
  class WorkflowsController < ApplicationController
    def index 
      @workflows = Wf::Workflow.order('id DESC').page(params[:page])
    end

    def new
      @workflow = Wf::Workflow.new
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
