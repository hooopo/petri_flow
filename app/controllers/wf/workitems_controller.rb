# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class WorkitemsController < ApplicationController
    before_action :find_workitem
    before_action :check_start, only: [:start]
    before_action :check_finish, only: %i[pre_finish finish]

    breadcrumb "Workflows", :workflows_path

    def show
      breadcrumb @workitem.workflow.name, workflow_path(@workitem.workflow)
      breadcrumb @workitem.case.name, workflow_case_path(@workitem.workflow, @workitem.case)
    end

    def start
      Wf::CaseCommand::StartWorkitem.call(@workitem, current_user)
      breadcrumb @workitem.workflow.name, workflow_path(@workitem.workflow)
      breadcrumb @workitem.case.name, workflow_case_path(@workitem.workflow, @workitem.case)
      breadcrumb @workitem.name, workitem_path(@workitem)
      render :pre_finish
    end

    def pre_finish
      breadcrumb @workitem.workflow.name, workflow_path(@workitem.workflow)
      breadcrumb @workitem.case.name, workflow_case_path(@workitem.workflow, @workitem.case)
      breadcrumb @workitem.name, workitem_path(@workitem)
    end

    def finish
      if @workitem.transition.form && params[:workitem][:entry]
        entry = @workitem.entries.find_or_create_by!(user: current_user)
        params[:workitem][:entry].permit!.each do |field_id, field_value|
          if field = entry.field_values.where(form: @workitem.transition.form, workflow: @workitem.workflow, field_id: field_id).first
            field.update!(value: field_value)
          else
            entry.field_values.create!(form: @workitem.transition.form, workflow: @workitem.workflow, field_id: field_id, value: field_value)
          end
        end
        entry.update_payload!
      end
      Wf::CaseCommand::FinishWorkitem.call(@workitem)
      if @workitem.case.finished?
        redirect_to workflow_case_path(@workitem.workflow, @workitem.case), notice: "workitem is done, and the case is finished."
      else
        redirect_to workitem_path(Wf::Workitem.last.case.workitems.enabled.first), notice: "workitem is done, and goto next fireable workitem."
      end
    end

    def find_workitem
      @workitem = Wf::Workitem.find(params[:id])
    end

    def check_start
      unless @workitem.started_by?(current_user)
        redirect_to workitem_path(@workitem), notice: "You can not start this workitem, Please assign to youself first."
      end
    end

    def check_finish
      unless @workitem.finished_by?(current_user)
        redirect_to workitem_path(@workitem), notice: "You can not the holding use of this workitem, Please assign to youself && start it first."
      end
    end
  end
end
