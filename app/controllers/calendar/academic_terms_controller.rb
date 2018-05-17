# frozen_string_literal: true

module Calendar
  class AcademicTermsController < ApplicationController
    before_action :authenticate_user!
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
      return redirect_to(academic_terms_url, notice: t('.success')) if @academic_term.save
      render(:new)
    end

    def update
      return redirect_to(academic_terms_url, notice: t('.success')) if @academic_term.update(academic_term_params)
      render(:edit)
    end

    def destroy
      redirect_to(academic_terms_url, notice: t('.success')) if @academic_term.destroy
    end

    private

    def set_academic_term
      @academic_term = AcademicTerm.find(params[:id])
    end

    def academic_term_params
      params.require(:academic_term).permit(:year, :term)
    end
  end
end
