# frozen_string_literal: true

module Calendar
  class CalendarTypesController < ApplicationController
    include PagyBackendWithHelpers

    before_action :set_calendar_type, only: %i[show edit update destroy]

    def index
      @calendar_types = pagy_by_search(CalendarType.all)
    end

    def show
      @titles = pagy_by_search(@calendar_type.titles)
    end

    def new
      @calendar_type = CalendarType.new
    end

    def edit; end

    def create
      @calendar_type = CalendarType.new(calendar_type_params)
      @calendar_type.save ? redirect_with('success') : render(:new)
    end

    def update
      @calendar_type.update(calendar_type_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @calendar_type.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(calendar_types_path, notice: t(".#{message}"))
    end

    def set_calendar_type
      @calendar_type = CalendarType.find(params[:id])
    end

    def calendar_type_params
      params.require(:calendar_type).permit(:name, unit_type_ids: [])
    end
  end
end
