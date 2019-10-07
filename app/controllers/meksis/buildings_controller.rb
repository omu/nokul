# frozen_string_literal: true

module Meksis
  class BuildingsController < ApplicationController
    include SearchableModule

    before_action :set_building, only: %i[edit show update]

    def index
      @buildings = Building.includes(:place_type).order(:name).dynamic_search(search_params(Building))
      @classrooms = Classroom.where(building_id: @buildings.ids)
      @pagy, @paginated = pagy(@buildings)

      respond_to do |format|
        format.html
        format.pdf { render pdf: 'report', no_background: true, footer: { center: '[page]' } }
      end
    end

    def show; end

    def edit; end

    def update
      @building.update(secure_params) ? redirect_to([:meksis, @building], notice: t('.success')) : render(:edit)
    end

    private

    def set_building
      @building = Building.find(params[:id])
    end

    def secure_params
      params.require(:building).permit(:latitude, :longitude)
    end
  end
end
