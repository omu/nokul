# frozen_string_literal: true

module Calendar
  class AcademicCalendarsController < ApplicationController
    before_action :set_academic_calendar, only: %i[show edit update destroy]

    def index
      @academic_calendars = AcademicCalendar.all
    end

    def show
      @events = @academic_calendar.calendar_events
    end

    def new
      @academic_calendar = AcademicCalendar.new
    end

    def edit; end

    def create
      @academic_calendar = AcademicCalendar.new(calendar_params)
      @academic_calendar.save ? redirect_with('success') : render(:new)
    end

    def update
      if @academic_calendar.update(calendar_params)
        redirect_to(@academic_calendar, notice: t('.success'))
      else
        render(:edit)
      end
    end

    def destroy
      redirect_with('success') if @academic_calendar.destroy
    end

    private

    def redirect_with(message)
      redirect_to(academic_calendars_path, notice: t(".#{message}"))
    end

    def set_academic_calendar
      @academic_calendar = AcademicCalendar.find(params[:id])
    end

    def calendar_params
      params.require(:academic_calendar)
            .permit(:name, :year, :academic_term_id, :calendar_type_id,
                    :senate_decision_date, :senate_decision_no, :description,
                    calendar_events_attributes: %i[id academic_calendar_id calendar_title_id
                                                   start_date end_date _destroy])
    end
  end
end
