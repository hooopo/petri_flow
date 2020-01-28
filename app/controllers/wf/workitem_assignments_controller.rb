# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class WorkitemAssignmentsController < ApplicationController
    def new
      @workitem = Wf::Workitem.find(params[:workitem_id])
      @workitem_assignment = @workitem.workitem_assignments.new(party_id: params[:party_id])
    end

    def create
      @workitem = Wf::Workitem.find(params[:workitem_id])
      party = Wf::Party.find(params[:workitem_assignment][:party_id])
      Wf::CaseCommand::AddWorkitemAssignment.call(@workitem, party)
      redirect_to workitem_path(@workitem), notice: "assigned party to workitem."
    end

    def destroy
      @workitem = Wf::Workitem.find(params[:workitem_id])
      party = Wf::Party.find(params[:party_id])
      Wf::CaseCommand::RemoveWorkitemAssignment.call(@workitem, party)
      render js: "window.location.reload()"
    end
  end
end
