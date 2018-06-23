# frozen_string_literal: true

module Calendar
  class AcademicCalendarsController < ApplicationController
    include Pagy::Backend

    before_action :set_academic_calendar, only: %i[show edit update destroy]
    before_action :set_root_breadcrumb, only: %i[index show new edit]

    def index
      @pagy, @academic_calendars = pagy(AcademicCalendar.includes(:academic_term, :calendar_type))
    end

    def show
      breadcrumb @academic_calendar.name, academic_calendars_path
      @pagy, @events = pagy(@academic_calendar.calendar_events.includes(:calendar_title))
    end

    def new
      breadcrumb t('.form_title'), new_academic_calendar_path
      @academic_calendar = AcademicCalendar.new
    end

    def edit
      breadcrumb t('.form_title'), edit_academic_calendar_path
    end

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

    def set_root_breadcrumb
      breadcrumb t('.index.card_header'), academic_calendars_path, match: :exact
    end

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
