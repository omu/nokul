# frozen_string_literal: true

module Location
  class CitiesController < ApplicationController
    include SearchableModule

    before_action :set_country
    before_action :set_city, only: %i[show edit update destroy]
    before_action :authorized?

    def show
      @districts = pagy_by_search(@city.districts.order(:name))
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
      if @city.destroy
        redirect_to(@country, notice: t('.success'))
      else
        redirect_to(@country, alert: t('.warning'))
      end
    end

    private

    def set_country
      @country = Country.find(params[:country_id])
    end

    def set_city
      @city = @country.cities.find(params[:id])
    end

    def authorized?
      authorize([:location, @city || City])
    end

    def city_params
      params.require(:city).permit(:name, :alpha_2_code, :latitude, :longitude)
    end
  end
end
