# frozen_string_literal: true

module Locations
  class DistrictsController < ApplicationController
    before_action :set_city
    before_action :set_district, only: %i[edit update destroy]
    before_action :add_breadcrumbs, only: %i[new edit]

    def new
      breadcrumb @country.name, country_path(@country), match: :exact
      breadcrumb @city.name, country_city_path(@country, @city), match: :exact
      breadcrumb t('.form_title'), new_country_city_district_path
      @district = @city.districts.new
    end

    def create
      @district = @city.districts.new(district_params)
      @city.save ? redirect_to([@country, @city], notice: t('.success')) : render(:new)
    end

    def edit
      breadcrumb @country.name, country_path(@country), match: :exact
      breadcrumb @city.name, country_city_path(@country, @city), match: :exact
      breadcrumb @district.name, edit_country_city_district_path(@country, @city, @district)
    end

    def update
      @district.update(district_params) ? redirect_to([@country, @city], notice: t('.success')) : render(:edit)
    end

    def destroy
      @district.destroy ? redirect_to([@country, @city], notice: t('.success')) : redirect_with('warning')
    end

    private

    def set_root_breadcrumb
      breadcrumb t('.common.countries'), countries_path, match: :exact
    end

    def set_city
      @country = Country.find(params[:country_id])
      @city = @country.cities.find(params[:city_id])
      not_found unless @city
    end

    def set_district
      @district = @city.districts.find(params[:id]) if @city
    end

    def district_params
      params.require(:district).permit(:name, :mernis_code, :active)
    end
  end
end
