# frozen_string_literal: true

class DocumentsController < ApplicationController
  include PagyBackendWithHelpers

  before_action :set_document, only: %i[edit update destroy show]

  def index
    @pagy, @documents = pagy(Document.all)
  end

  def show; end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    @document.save ? redirect_to(@document, notice: t('.success')) : render(:new)
  end

  def edit; end

  def update
    @document.update(document_params) ? redirect_to(@document, notice: t('.success')) : render(:edit)
  end

  def destroy
    if @document.destroy
      redirect_to(documents_path, notice: t('.success'))
    else
      redirect_to(documents_path, alert: t('.warning'))
    end
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(
      :name, :statement
    )
  end
end
