# frozen_string_literal: true

module Committee
  class AgendaTypesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_agenda_type, only: %i[edit update destroy]

    def index
      @agenda_types = pagy_by_search(AgendaType.all)
    end

    def new
      @agenda_type = AgendaType.new
    end

    def edit; end

    def create
      @agenda_type = AgendaType.new(agenda_type_params)
      @agenda_type.save ? redirect_with('success') : render(:new)
    end

    def update
      @agenda_type.update(agenda_type_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @agenda_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(agenda_types_path, notice: t(".#{message}"))
    end

    def set_agenda_type
      @agenda_type = AgendaType.find(params[:id])
    end

    def agenda_type_params
      params.require(:agenda_type).permit(:name)
    end
  end
end
