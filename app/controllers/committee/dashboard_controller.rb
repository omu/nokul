# frozen_string_literal: true

module Committee
  class DashboardController < ApplicationController
    include PagyBackendWithHelpers

    def index
      @committees = pagy_by_search(
        Unit.committees.includes(:unit_type, :unit_status, district: :city)
      )
    end

    def show
      @committee = Unit.committees.find(params[:id])
      @agendas = pagy_by_search(
        @committee.agendas.includes(:agenda_type, agenda_file_attachment: :blob)
      )
    end
  end
end
