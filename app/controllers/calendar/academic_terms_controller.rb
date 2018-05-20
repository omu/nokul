# frozen_string_literal: true

module Calendar
  class AcademicTermsController < ApplicationController
    before_action :set_academic_term, only: %i[edit update destroy]

    def index
      @academic_terms = AcademicTerm.all
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
      redirect_with('success') if @academic_term.destroy
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
