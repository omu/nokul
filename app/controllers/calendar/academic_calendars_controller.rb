# frozen_string_literal: true

module Calendar
  class AcademicCalendarsController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_academic_calendar, only: %i[show edit update destroy]

    def index
      @academic_calendars = pagy_by_search(
        AcademicCalendar.includes(:academic_term, :calendar_type).order(created_at: :desc)
      )
    end

    def show
      @events = pagy_by_search(@academic_calendar.calendar_events.order(:start_date).includes(:calendar_title))
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
      @academic_calendar.destroy ? redirect_with('success') : redirect_with('warning')
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
            .permit(
              :name, :year, :academic_term_id, :calendar_type_id,
              :senate_decision_date, :senate_decision_no, :description,
              calendar_events_attributes: %i[
                id calendar_type_id academic_term_id calendar_title_id start_date end_date _destroy
              ],
              unit_ids: []
            )
    end
  end
end
