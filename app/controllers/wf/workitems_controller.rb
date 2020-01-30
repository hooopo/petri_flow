# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class WorkitemsController < ApplicationController
    before_action :find_workitem
    before_action :check_start, only: [:start]
    before_action :check_finish, only: %i[pre_finish finish]

    def show; end

    def start
      Wf::CaseCommand::StartWorkitem.call(@workitem, current_user)
      render :pre_finish
    end

    def pre_finish; end

    def finish
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
