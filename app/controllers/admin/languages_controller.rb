# frozen_string_literal: true

module Admin
  class LanguagesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_language, only: %i[edit update destroy]

    def index
      @languages = pagy_by_search(Language.order(:name))
    end

    def new
      @language = Language.new
    end

    def create
      @language = Language.new(language_params)
      @language.save ? redirect_to(admin_languages_path, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @language.update(language_params) ? redirect_to(admin_languages_path, notice: t('.success')) : render(:edit)
    end

    def destroy
      if @language.destroy
        redirect_to(admin_languages_path, notice: t('.success'))
      else
        redirect_to(admin_languages_path, alert: t('.warning'))
      end
    end

    private

    def set_language
      @language = Language.find(params[:id])
    end

    def language_params
      params.require(:language).permit(:name, :iso)
    end
  end
end
