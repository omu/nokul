# frozen_string_literal: true

module Calendar
  class CalendarTitlesController < ApplicationController
    include Pagy::Backend

    before_action :set_calendar_title, only: %i[edit update destroy]
    before_action :add_breadcrumbs, only: %i[index new edit]

    def index
      @pagy, @calendar_titles = if params[:term].present?
                                  pagy(CalendarTitle.search(params[:term]))
                                else
                                  pagy(CalendarTitle.all)
                                end
    end

    def new
      @calendar_title = CalendarTitle.new
    end

    def edit; end

    def create
      @calendar_title = CalendarTitle.new(calendar_title_params)
      @calendar_title.save ? redirect_with('success') : render(:new)
    end

    def update
      @calendar_title.update(calendar_title_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @calendar_title.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(calendar_titles_path, notice: t(".#{message}"))
    end

    def set_calendar_title
      @calendar_title = CalendarTitle.find(params[:id])
    end

    def calendar_title_params
      params.require(:calendar_title).permit(:name)
    end

    def add_breadcrumbs
      breadcrumb t('.index.card_header'), calendar_titles_path, match: :exact
      case params[:action]
      when 'new', 'edit'
        breadcrumb t('.form_title'), calendar_titles_path
      end
    end
  end
end
