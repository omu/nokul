# frozen_string_literal: true

module Calendar
  class CalendarTypesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_calendar_type, only: %i[show edit update destroy]

    def index
      @calendar_types = CalendarType.all
    end

    def show
      @titles = @calendar_type.titles
    end

    def new
      @calendar_type = CalendarType.new
    end

    def edit; end

    def create
      @calendar_type = CalendarType.new(calendar_type_params)
      return redirect_to(calendar_types_url, notice: t('.success')) if @calendar_type.save
      render(:new)
    end

    def update
      return redirect_to(calendar_types_url, notice: t('.success')) if @calendar_type.update(calendar_type_params)
      render(:edit)
    end

    def destroy
      redirect_to(calendar_types_url, notice: t('.success')) if @calendar_type.destroy
    end

    private

    def set_calendar_type
      @calendar_type = CalendarType.find(params[:id])
    end

    def calendar_type_params
      params.require(:calendar_type)
            .permit(:name, calendar_title_types_attributes: %i[id type_id title_id status _destroy])
    end
  end
end
