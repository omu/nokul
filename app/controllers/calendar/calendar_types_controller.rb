# frozen_string_literal: true

module Calendar
  class CalendarTypesController < ApplicationController
    include Pagy::Backend

    before_action :set_calendar_type, only: %i[show edit update destroy]
    before_action :add_breadcrumbs, only: %i[index show new edit]

    def index
      @pagy, @calendar_types = pagy(CalendarType.all)
    end

    def show
      @pagy, @titles = pagy(@calendar_type.titles)
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
      params.require(:calendar_type)
            .permit(:name, calendar_title_types_attributes: %i[id type_id title_id status _destroy])
    end

    def add_breadcrumbs
      breadcrumb t('.index.card_header'), calendar_types_path, match: :exact
      case params[:action]
      when 'show'
        breadcrumb @calendar_type.name, calendar_type_path
      when 'new', 'edit'
        breadcrumb t('.form_title'), calendar_types_path
      end
    end
  end
end
