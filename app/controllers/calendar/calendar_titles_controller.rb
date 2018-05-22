# frozen_string_literal: true

module Calendar
  class CalendarTitlesController < ApplicationController
    before_action :set_calendar_title, only: %i[edit update destroy]

    def index
      @calendar_titles = CalendarTitle.all
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
  end
end
