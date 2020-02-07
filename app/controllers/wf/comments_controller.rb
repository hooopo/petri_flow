# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class CommentsController < ApplicationController
    breadcrumb "Workflows", :workflows_path

    def new
      @workitem = Wf::Workitem.find(params[:workitem_id])
      @comment = @workitem.comments.new
      breadcrumb @workitem.workflow.name, workflow_path(@workitem.workflow)
      breadcrumb @workitem.case.name, workflow_case_path(@workitem.workflow, @workitem.case)
      breadcrumb @workitem.name, workitem_path(@workitem)
    end

    def create
      @workitem = Wf::Workitem.find(params[:workitem_id])
      Wf::CaseCommand::AddComment.call(@workitem, params[:comment][:body], wf_current_user)
      redirect_to workitem_path(@workitem), notice: "Comment Added."
    end

    def destroy
      @workitem = Wf::Workitem.find(params[:workitem_id])
      @comment = @workitem.comments.find(params[:id])
      @comment.destroy
      render js: "window.location.reload()"
    end
  end
end
