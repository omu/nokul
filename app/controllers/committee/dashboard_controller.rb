# frozen_string_literal: true

module Committee
  class DashboardController < ApplicationController
    include PagyBackendWithHelpers

    def index
      @committees = pagy_by_search(
        Unit.committees.includes(:unit_type, :unit_status, district: :city)
      )
    end
  end
end
