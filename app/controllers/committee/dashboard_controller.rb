# frozen_string_literal: true

module Committee
  class DashboardController < ApplicationController
    def index
      @committees = pagy_by_search(
        Unit.committees.includes(:unit_type, :unit_status, district: :city)
      )
    end

    def show
      @agendas = pagy_by_search(
        Unit.find(params[:id]).agendas.includes(:agenda_type)
      )
    end
  end
end
