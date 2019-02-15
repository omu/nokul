# frozen_string_literal: true

module TermManagement
  class AcademicTermsController < ApplicationController
    include SearchableModule

    before_action :set_academic_term, only: %i[edit update destroy]

    def index
      @academic_terms = pagy_by_search(AcademicTerm.order(:year, :term))
    end

    def new
      @academic_term = AcademicTerm.new
    end

    def edit; end

    def create
      @academic_term = AcademicTerm.new(academic_term_params)
      @academic_term.save ? redirect_with('success') : render(:new)
    end

    def update
      @academic_term.update(academic_term_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @academic_term.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(academic_terms_path, notice: t(".#{message}"))
    end

    def set_academic_term
      @academic_term = AcademicTerm.find(params[:id])
    end

    def academic_term_params
      params.require(:academic_term).permit(:year, :term, :start_of_term, :end_of_term, :active)
    end
  end
end
