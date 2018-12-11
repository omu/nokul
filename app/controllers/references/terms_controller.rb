# frozen_string_literal: true

module References
  class TermsController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_term, only: %i[show edit update destroy]

    def index
      @terms = pagy_by_search(Term.all.order(:name))
    end

    def new
      @term = Term.new
    end

    def create
      @term = Term.new(term_params)
      @term.save ? redirect_to(terms_path, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @term.update(term_params) ? redirect_to(terms_path, notice: t('.success')) : render(:edit)
    end

    def destroy
      message = @term.destroy ? t('.success') : t('.warning')
      redirect_to(terms_path, notice: message)
    end

    private

    def set_term
      @term = Term.find(params[:id])
    end

    def term_params
      params.require(:term).permit(:name, :identifier)
    end
  end
end
