# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class FormsController < ApplicationController
    breadcrumb "Forms", :forms_path
    
    def index
      @forms = Wf::Form.order("id DESC").page(params[:page])
    end

    def new
      @form = Wf::Form.new
    end

    def edit
      @form = Wf::Form.find(params[:id])
    end

    def show
      @form = Wf::Form.find(params[:id])
    end

    def destroy
      @form = Wf::Form.find(params[:id])
      @form.destroy
      respond_to do |format|
        format.html { redirect_to forms_path, notice: "form was successfully deleted." }
        format.js { render js: "window.location.reload();" }
      end
    end

    def update
      @form = Wf::Form.find(params[:id])
      if @form.update(form_params)
        redirect_to form_path(@form), notice: "form was successfully updated."
      else
        render :edit
      end
    end

    def create
      @form = Wf::Form.new(form_params)

      if @form.save
        redirect_to forms_path, notice: "form was successfully created."
      else
        render :new
      end
    end

    private

      def form_params
        params.fetch(:form, {}).permit(:name, :description)
      end
  end
end
