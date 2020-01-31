# frozen_string_literal: true

require_dependency "wf/application_controller"

module Wf
  class FieldsController < ApplicationController
    breadcrumb "Forms", :forms_path

    def new
      @form = Wf::Form.find(params[:form_id])
      @field = @form.fields.new
      breadcrumb @form.name, form_path(@form)
    end

    def create
      @form = Wf::Form.find(params[:form_id])
      @field = @form.fields.new(field_params)
      if @field.save
        redirect_to form_path(@form), notice: "field was successfully created."
      else
        render :new
      end
    end

    def destroy
      @form = Wf::Form.find(params[:form_id])
      @field = @form.fields.find(params[:id])
      @field.destroy
      render js: "window.location.reload()"
    end

    def edit
      @form = Wf::Form.find(params[:form_id])
      @field = @form.fields.find(params[:id])
      breadcrumb @form.name, form_path(@form)
    end

    def update
      @form = Wf::Form.find(params[:form_id])
      @field = @form.fields.find(params[:id])
      if @field.update(field_params)
        redirect_to form_path(@form), notice: "field was successfully created."
      else
        render :edit
      end
    end

    private

      def field_params
        params.fetch(:field, {}).permit(:name, :form_id, :field_type, :position, :default_value)
      end
  end
end
