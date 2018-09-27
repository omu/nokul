# frozen_string_literal: true

class RegistrationDocumentsController < ApplicationController
  before_action :set_unit
  before_action :set_registration_document, only: %i[show edit update destroy]

  def index
    @registration_documents = @unit.registration_documents.includes(:academic_term, :document).order(created_at: :desc)
  end

  def show; end

  def new
    @registration_document = @unit.registration_documents.new
  end

  def create
    @registration_document = @unit.registration_documents.new(document_params)
    @registration_document.save ? redirect_to(@unit, notice: t('.success')) : render(:new)
  end

  def edit; end

  def update
    @registration_document.update(document_params) ? redirect_to(@unit, notice: t('.success')) : render(:edit)
  end

  def destroy
    if @registration_document.destroy
      redirect_to(@unit, notice: t('.success'))
    else
      redirect_to(@unit, alert: t('.warning'))
    end
  end

  private

  def set_unit
    @unit = Unit.programs.find(params[:unit_id])
  end

  def set_registration_document
    @registration_document = @unit.registration_documents.find(params[:id])
  end

  def document_params
    params.require(:registration_document).permit(:unit_id, :academic_term_id, :document_id)
  end
end
