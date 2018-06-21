# frozen_string_literal: true

module Locations
  class CountriesController < ApplicationController
    include Pagy::Backend
    before_action :set_country, only: %i[show edit update destroy]

    def index
      breadcrumb 'Ülkeler', countries_path
      countries = Country.all

      @pagy, @countries = if params[:term].present?
                            pagy(countries.search(params[:term]))
                          else
                            pagy(countries)
                          end
    end

    def show
      breadcrumb 'Ülkeler', countries_path, match: :exact
      breadcrumb @country.name, country_path(@country)
      @pagy, @cities = pagy(@country.cities)
    end

    def new
      breadcrumb 'Ülkeler', countries_path, match: :exact
      breadcrumb 'Yeni Ülke', new_country_path
      @country = Country.new
    end

    def create
      @country = Country.new(country_params)
      @country.save ? redirect_to(@country, notice: t('.success')) : render(:new)
    end

    def edit
      breadcrumb 'Ülkeler', countries_path, match: :exact
      breadcrumb @country.name, edit_country_path(@country)
    end

    def update
      @country.update(country_params) ? redirect_to(@country, notice: t('.success')) : render(:edit)
    end

    def destroy
      @country.destroy ? redirect_to(countries_path, notice: t('.success')) : redirect_with('warning')
    end

    private

    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.require(:country).permit(:name, :iso, :code)
    end
  end
end
