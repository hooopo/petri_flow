require_dependency "wf/application_controller"

module Wf
  class CasesController < ApplicationController
    def new
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @case = @workflow.cases.new
    end

    def create
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @case = @workflow.cases.new(case_params)
      if @case.save
        redirect_to workflow_path(@workflow), notice: "case was successfully created."
      else
        render :new
      end
    end

    def destroy
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @case = @workflow.cases.find(params[:id])
      @case.destroy
      render :js => 'window.location.reload()'
    end

    def edit
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @case = @workflow.cases.find(params[:id])
    end

    def update
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @case = @workflow.cases.find(params[:id])
      if @case.update(case_params)
        redirect_to workflow_path(@workflow), notice: "case was successfully created."
      else
        render :edit
      end
    end

    private

    def case_params
      params.fetch(:case, {}).permit(:name, :description, :case_type, :sort_order)
    end
  end
end
