# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class CasesController < ApplicationController
    breadcrumb "Workflows", :workflows_path
    def new
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @wf_case = @workflow.cases.new
      breadcrumb @workflow.name, workflow_path(@workflow)
    end

    def create
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @wf_case = Wf::CaseCommand::New.call(@workflow, GlobalID::Locator.locate(case_params[:targetable])).result
      Wf::CaseCommand::StartCase.call(@wf_case)
      redirect_to workflow_cases_path(@workflow), notice: "case created."
    end

    def index
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @cases = @workflow.cases
      @cases = @cases.where(state: params[:state].intern) if params[:state].present?
      @cases = @cases.page(params[:page])
      breadcrumb @workflow.name, workflow_path(@workflow)
    end

    def show
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @wf_case = @workflow.cases.find(params[:id])
      breadcrumb @workflow.name, workflow_path(@workflow)
    end

    def destroy
      @workflow = Wf::Workflow.find(params[:workflow_id])
      @case = @workflow.cases.find(params[:id])
      @case.destroy
      render js: "window.location.reload()"
    end

    private

      def case_params
        params.fetch(:case, {}).permit(:targetable, :target_id, :target_type)
      end
  end
end
