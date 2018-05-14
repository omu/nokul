# frozen_string_literal: true

module Calendar
  class AcademicCalendarsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_academic_calendar, only: %i[show edit update destroy]

    # GET /academic_calendars
    # GET /academic_calendars.json
    def index
      @academic_calendars = AcademicCalendar.all
    end

    # GET /academic_calendars/1
    # GET /academic_calendars/1.json
    def show; end

    # GET /academic_calendars/new
    def new
      @academic_calendar = AcademicCalendar.new
    end

    # GET /academic_calendars/1/edit
    def edit; end

    # POST /academic_calendars
    # POST /academic_calendars.json
    def create
      @academic_calendar = AcademicCalendar.new(academic_calendar_params)

      respond_to do |format|
        if @academic_calendar.save
          format.html { redirect_to @academic_calendar, notice: 'Academic calendar was successfully created.' }
          format.json { render :show, status: :created, location: @academic_calendar }
        else
          format.html { render :new }
          format.json { render json: @academic_calendar.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /academic_calendars/1
    # PATCH/PUT /academic_calendars/1.json
    def update
      respond_to do |format|
        if @academic_calendar.update(academic_calendar_params)
          format.html { redirect_to @academic_calendar, notice: 'Academic calendar was successfully updated.' }
          format.json { render :show, status: :ok, location: @academic_calendar }
        else
          format.html { render :edit }
          format.json { render json: @academic_calendar.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /academic_calendars/1
    # DELETE /academic_calendars/1.json
    def destroy
      @academic_calendar.destroy
      respond_to do |format|
        format.html { redirect_to academic_calendars_url, notice: 'Academic calendar was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_academic_calendar
      @academic_calendar = AcademicCalendar.find(params[:id])
      @calendar_titles = @academic_calendar.calendar_type.titles
    end

    def academic_calendar_params
      params.require(:academic_calendar)
            .permit(:name, :year, :academic_term_id, :calendar_type_id,
                    :senate_decision_date, :senate_decision_no, :description,
                    calendar_events_attributes: %i[id academic_calendar_id calendar_title_id
                                                   start_date end_date _destroy])
    end
  end
end
