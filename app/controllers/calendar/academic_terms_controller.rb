# frozen_string_literal: true

module Calendar
  class AcademicTermsController < ApplicationController
    include Pagy::Backend
    before_action :set_academic_term, only: %i[edit update destroy]

    def index
      breadcrumb t('.card_header'), academic_terms_path
      @pagy, @academic_terms = pagy(AcademicTerm.all)
    end

    def new
       breadcrumb t('.index.card_header'), academic_terms_path, match: :exact
       breadcrumb t('.form_title'), new_academic_term_path
      @academic_term = AcademicTerm.new
    end

    def edit
       breadcrumb t('.index.card_header'), academic_terms_path, match: :exact
       breadcrumb t('.form_title'), edit_academic_term_path
    end

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
      params.require(:academic_term).permit(:year, :term)
    end
  end
end
