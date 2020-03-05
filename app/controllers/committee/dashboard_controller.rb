# frozen_string_literal: true

module Committee
  class DashboardController < ApplicationController
    include SearchableModule

    def index
      @committees = pagy_by_search(
        Unit.includes(:unit_type, district: :city).committees.active.order(:name)
      )

      authorize(@committees, policy_class: Committee::DashboardPolicy)
    end
  end
end
