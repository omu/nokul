# frozen_string_literal: true

module CalendarManagement
  class CalendarsController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_calendar, only: %i[show edit update destroy]

    def index
      @calendars = pagy_by_search(Calendar.includes(:academic_term).order(created_at: :desc))
    end

    def show; end

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
      clone_calendar = @calendar.dup
      clone_calendar.name.prepend('[Kopyası] ')
      redirect_with('warning') && return unless clone_calendar.save
      @calendar.calendar_events.each do |event|
        clone_event = event.dup
        clone_event.calendar = clone_calendar
        clone_event.save!
      end

      redirect_to([:edit, :calendar_management, clone_calendar], notice: t('.success'))
    end

    private

    def redirect_with(message)
      redirect_to([:calendar_management, 'calendars'], notice: t(".#{message}"))
    end

    def set_calendar
      @calendar = Calendar.includes(calendar_events: [:calendar_event_type]).find(params[:id])
    end

    def calendar_params
      params.require(:calendar).permit(
        :name, :senate_decision_date, :senate_decision_no, :description, :timezone, :academic_term_id,
        calendar_events_attributes: %i[
          id calendar_event_type_id start_time end_time location timezone visible _destroy
        ]
      )
    end
  end
end
