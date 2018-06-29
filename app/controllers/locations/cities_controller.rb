# frozen_string_literal: true

module Locations
  class CitiesController < ApplicationController
    include Pagy::Backend

    before_action :set_country
    before_action :set_city, only: %i[show edit update destroy]

    def show
      districts = @city.districts

      @pagy, @districts = if params[:term].present?
                            pagy(districts.search(params[:term]))
                          else
                            pagy(districts)
                          end
    end

    def new
      @city = @country.cities.new
    end

    def create
      @city = @country.cities.new(city_params)
      @city.save ? redirect_to([@country, @city], notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @city.update(city_params) ? redirect_to([@country, @city], notice: t('.success')) : render(:edit)
    end

    def destroy
      @city.destroy ? redirect_to(@country, notice: t('.success')) : redirect_with('warning')
    end

    private

    def set_country
      @country = Country.find(params[:country_id])
      not_found unless @country
    end

    def set_city
      @city = @country.cities.find(params[:id]) if @country
    end

    def city_params
      params.require(:city).permit(:name, :alpha_2_code)
    end
  end
end
