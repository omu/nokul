# frozen_string_literal: true

module Locations
  class DistrictsController < ApplicationController
    before_action :set_city_and_country
    before_action :set_district, only: %i[edit update destroy]

    def new
      @district = @city.districts.new
    end

    def create
      @district = @city.districts.new(district_params)
      @city.save ? redirect_to([@country, @city], notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @district.update(district_params) ? redirect_to([@country, @city], notice: t('.success')) : render(:edit)
    end

    def destroy
      @district.destroy ? redirect_to([@country, @city], notice: t('.success')) : redirect_with('warning')
    end

    private

    def set_city_and_country
      @city = City.find(params[:city_id])
      not_found unless @city
      @country = @city.country
    end

    def set_district
      @district = @city.districts.find(params[:id]) if @city
    end

    def district_params
      params.require(:district).permit(:name, :mernis_code, :active)
    end
  end
end
