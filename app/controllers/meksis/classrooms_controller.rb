# frozen_string_literal: true

module Meksis
  class ClassroomsController < ApplicationController
    include SearchableModule

    before_action :set_building, only: :index

    def index
      classrooms = @building.classrooms.includes(:place_type).order(:name)
      @pagy, @classrooms = pagy(classrooms.dynamic_search(search_params(Classroom)))
    end

    def show
      @classroom = Classroom.find(params[:id])
    end

    private

    def set_building
      @building = Building.find(params[:building_id])
    end
  end
end
