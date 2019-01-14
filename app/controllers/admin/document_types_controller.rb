# frozen_string_literal: true

module Admin
  class DocumentTypesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_document_type, only: %i[edit update destroy]

    def index
      @document_types = pagy_by_search(DocumentType.order(:name))
    end

    def new
      @document_type = DocumentType.new
    end

    def create
      @document_type = DocumentType.new(document_type_params)
      @document_type.save ? redirect_to([:admin, 'document_types'], notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      if @document_type.update(document_type_params)
        redirect_to([:admin, 'document_types'], notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      if @document_type.destroy
        redirect_to([:admin, 'document_types'], notice: t('.success'))
      else
        redirect_to([:admin, 'document_types'], notice: t('.warning'))
      end
    end

    private

    def set_document_type
      @document_type = DocumentType.find(params[:id])
    end

    def document_type_params
      params.require(:document_type).permit(:name, :active)
    end
  end
end
