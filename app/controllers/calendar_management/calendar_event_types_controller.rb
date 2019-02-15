# frozen_string_literal: true

module CalendarManagement
  class CalendarEventTypesController < ApplicationController
    include SearchableModule

    before_action :set_calendar_event_type, only: %i[edit update destroy]

    def index
      @calendar_event_types = pagy_by_search(CalendarEventType.order(:name))
    end

    def new
      @calendar_event_type = CalendarEventType.new
    end

    def create
      @calendar_event_type = CalendarEventType.new(calendar_event_type_params)
      @calendar_event_type.save ? redirect_to(:calendar_event_types, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      if @calendar_event_type.update(calendar_event_type_params)
        redirect_to(:calendar_event_types, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      if @calendar_event_type.destroy
        redirect_to(:calendar_event_types, notice: t('.success'))
      else
        redirect_to(:calendar_event_types, alert: t('.warning'))
      end
    end

    private

    def set_calendar_event_type
      @calendar_event_type = CalendarEventType.find(params[:id])
    end

    def calendar_event_type_params
      params.require(:calendar_event_type).permit(:name, :identifier, :category)
    end
  end
end
