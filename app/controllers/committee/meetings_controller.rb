# frozen_string_literal: true

module Committee
  class MeetingsController < ApplicationController
    before_action :set_committee
    before_action :set_meeting, only: %i[show edit update destroy]

    def index
      @meetings = @committee.meetings.order(year: :desc, meeting_no: :asc)
    end

    def show
      @agendas = @meeting.meeting_agendas.includes(:decision, agenda: :agenda_type).order(:sequence_no)
    end

    def new
      @meeting = @committee.meetings.new
    end

    def edit; end

    def create
      @meeting = @committee.meetings.new(meeting_params)
      @meeting.save ? redirect_with('success') : render(:new)
    end

    def update
      @meeting.update(meeting_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @meeting.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(committee_meetings_path(@committee), notice: t(".#{message}"))
    end

    def set_committee
      @committee = Unit.find(params[:committee_id])
    end

    def set_meeting
      @meeting = @committee.meetings.find(params[:id])
    end

    def meeting_params
      params.require(:committee_meeting)
            .permit(:meeting_no, :meeting_date,
                    meeting_agendas_attributes: %i[
                      id agenda_id committee_meeting_id sequence_no _destroy
                    ])
    end
  end
end
