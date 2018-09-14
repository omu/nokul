# frozen_string_literal: true

module Committee
  class AgendasController < ApplicationController
    include Pagy::Backend

    before_action :set_agenda, only: %i[edit update destroy]
    before_action :set_committee

    def index
      agendas = Agenda.where(unit: @committee).includes(:unit, :agenda_type)
      @pagy, @agendas = if params[:term].present?
                          pagy(agendas.search(params[:term]))
                        else
                          pagy(agendas)
                        end
    end

    def new
      @agenda = Agenda.new
    end

    def edit; end

    def create
      @agenda = Agenda.new(agenda_params)
      @agenda.save ? redirect_with('success') : render(:new)
    end

    def update
      @committee = Unit.find(agenda_params[:unit_id])
      @agenda.update(agenda_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @agenda.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(committee_agendas_path(@committee), notice: t(".#{message}"))
    end

    def set_agenda
      @agenda = Agenda.find(params[:id])
    end

    def set_committee
      @committee = Unit.find(params[:committee_id])
    end

    def agenda_params
      params.require(:agenda).permit(:description, :status, :unit_id, :agenda_type_id)
    end
  end
end
