# frozen_string_literal: true

module Calendar
  class CalendarTitlesController < ApplicationController
    before_action :authenticate_user!
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
      return redirect_to(calendar_titles_url, notice: t('.success')) if @calendar_title.save
      render(:new)
    end

    def update
      return redirect_to(calendar_titles_url, notice: t('.success')) if @calendar_title.update(calendar_title_params)
      render(:edit)
    end

    def destroy
      redirect_to(calendar_titles_url, notice: t('.success')) if @calendar_title.destroy
    end

    private

    def set_calendar_title
      @calendar_title = CalendarTitle.find(params[:id])
    end

    def calendar_title_params
      params.require(:calendar_title).permit(:name)
    end
  end
end
