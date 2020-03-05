# frozen_string_literal: true

module Meksis
  class PlaceTypesController < ApplicationController
    include SearchableModule

    def index
      @place_types = pagy_by_search(PlaceType.roots.order(:name))

      authorize([:meksis, @place_types])
    end

    def show
      @place_type = PlaceType.find(params[:id])
      @children = pagy_by_search(@place_type.children.order(:name))

      authorize([:meksis, @place_type])
    end
  end
end
