# frozen_string_literal: true

module Committee
  class DashboardController < ApplicationController
    include Pagy::Backend

    def index
      units = Unit.committees.includes(:unit_type, :unit_status, district: :city)
      @pagy, @committees = if params[:term].present?
                             pagy(units.search(params[:term]))
                           else
                             pagy(units)
                           end
    end

    def show
      @committee = Unit.find(params[:id])
      agendas = @committee.agendas.includes(:agenda_type)
      @pagy, @agendas = if params[:term].present?
                          pagy(agendas.search(params[:term]))
                        else
                          pagy(agendas)
                        end
    end
  end
end
