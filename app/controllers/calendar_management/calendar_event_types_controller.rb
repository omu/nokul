# frozen_string_literal: true

module CalendarManagement
  class CalendarEventTypesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_calendar_event_type, only: %i[edit update destroy]

    def index
      @calendar_event_types = pagy_by_search(CalendarEventType.order(:name))
    end

    def new
      @calendar_event_type = CalendarEventType.new
    end

    def create
      @calendar_event_type = CalendarEventType.new(calendar_event_type_params)
      @calendar_event_type.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @calendar_event_type.update(calendar_event_type_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @calendar_event_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to([:calendar_management, 'calendar_event_types'], notice: t(".#{message}"))
    end

    def set_calendar_event_type
      @calendar_event_type = CalendarEventType.find(params[:id])
    end

    def calendar_event_type_params
      params.require(:calendar_event_type).permit(:name, :identifier, :category)
    end
  end
end
