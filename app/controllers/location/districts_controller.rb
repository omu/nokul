# frozen_string_literal: true

module Location
  class DistrictsController < ApplicationController
    before_action :set_city
    before_action :set_district, only: %i[edit update destroy]

    def new
      @district = @city.districts.new
    end

    def create
      @district = @city.districts.new(district_params)
      @city.save ? redirect_to(index_path, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      if @district.update(district_params)
        redirect_to(index_path, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      if @district.destroy
        redirect_to(index_path, notice: t('.success'))
      else
        redirect_to(index_path, alert: t('.warning'))
      end
    end

    private

    def index_path
      [@city.country, @city]
    end

    def set_city
      @city = City.find(params[:city_id])
    end

    def set_district
      @district = @city.districts.find(params[:id])
    end

    def district_params
      params.require(:district).permit(:name, :mernis_code, :active)
    end
  end
end
