# frozen_string_literal: true

module CalendarManagement
  class CalendarsController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_calendar, only: %i[show edit update destroy]

    def index
      @calendars = pagy_by_search(Calendar.includes(:academic_term).order(created_at: :desc))
    end

    def show
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: @calendar.name
        end
      end
    end

    def new
      @calendar = Calendar.new
    end

    def create
      @calendar = Calendar.new(calendar_params)
      @calendar.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @calendar.update(calendar_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @calendar.destroy ? redirect_with('success') : redirect_with('warning')
    end

    def duplicate
      @calendar = Calendar.find(params[:calendar_id])
      @duplicate_record = DuplicateService.new(@calendar, 'name').duplicate

      redirect_with('warning') && return unless @duplicate_record

      AcademicCalendars::DuplicateEventsService.new(@calendar, @duplicate_record)

      redirect_to([:edit, :calendar_management, @duplicate_record], notice: t('.success'))
    end

    def units
      @calendar = Calendar.find(params[:calendar_id])
    end

    private

    def redirect_with(message)
      redirect_to([:calendar_management, 'calendars'], notice: t(".#{message}"))
    end

    def set_calendar
      @calendar = Calendar.includes(calendar_events: [:calendar_event_type]).find(params[:id])
    end

    def calendar_params
      params.require(:calendar)
            .permit(
              :name, :senate_decision_date, :senate_decision_no, :description, :timezone, :academic_term_id,
              unit_ids: [], calendar_events_attributes: %i[
                id calendar_event_type_id start_time end_time location timezone visible _destroy
              ]
            )
    end
  end
end
