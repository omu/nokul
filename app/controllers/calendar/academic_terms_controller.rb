# frozen_string_literal: true

module Calendar
  class AcademicTermsController < ApplicationController
    include Pagy::Backend

    before_action :set_academic_term, only: %i[edit update destroy]
    before_action :add_breadcrumbs, only: %i[index new edit]

    def index
      @pagy, @academic_terms = pagy(AcademicTerm.all)
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
      params.require(:academic_term).permit(:year, :term)
    end

    def add_breadcrumbs
      breadcrumb t('.index.card_header'), academic_terms_path, match: :exact
      case params[:action]
      when 'new', 'edit'
        breadcrumb t('.form_title'), academic_terms_path
      end
    end
  end
end
