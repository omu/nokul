# frozen_string_literal: true

module Admin
  class CountriesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_country, only: %i[show edit update destroy]

    def index
      @countries = pagy_by_search(Country.order(:name))
    end

    def show
      @cities = pagy_by_search(@country.cities.order(:name))
    end

    def new
      @country = Country.new
    end

    def create
      @country = Country.new(country_params)
      @country.save ? redirect_to([:admin, @country], notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @country.update(country_params) ? redirect_to([:admin, @country], notice: t('.success')) : render(:edit)
    end

    def destroy
      if @country.destroy
        redirect_to(index_path, notice: t('.success'))
      else
        redirect_to(index_path, alert: t('.warning'))
      end
    end

    private

    def index_path
      %i[admin countries]
    end

    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.require(:country).permit(:name, :alpha_2_code, :alpha_3_code, :numeric_code, :mernis_code, :yoksis_code)
    end
  end
end
