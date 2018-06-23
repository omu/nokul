# frozen_string_literal: true

module Calendar
  class CalendarTypesController < ApplicationController
    include Pagy::Backend
    before_action :set_calendar_type, only: %i[show edit update destroy]

    def index
      breadcrumb t('.card_header'), calendar_types_path
      @pagy, @calendar_types = pagy(CalendarType.all)
    end

    def show
      breadcrumb t('.index.card_header'), calendar_types_path, match: :exact
      breadcrumb "#{@calendar_type.name}", calendar_type_path
      @titles = @calendar_type.titles
    end

    def new
      breadcrumb t('.index.card_header'), calendar_types_path, match: :exact
      breadcrumb t('.form_title'), new_calendar_type_path
      @calendar_type = CalendarType.new
    end

    def edit
      breadcrumb t('.index.card_header'), calendar_types_path, match: :exact
      breadcrumb t('.form_title'), edit_calendar_type_path
    end

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
      params.require(:calendar_type)
            .permit(:name, calendar_title_types_attributes: %i[id type_id title_id status _destroy])
    end
  end
end
