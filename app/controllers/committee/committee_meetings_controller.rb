# frozen_string_literal: true

module Committee
  class CommitteeMeetingsController < ApplicationController
    before_action :set_committee
    before_action :set_committee_meeting, only: %i[edit update destroy]

    def index
      @committee_meetings = @committee.meetings.order(year: :desc, meeting_no: :asc)
    end

    def new
      @committee_meeting = CommitteeMeeting.new
    end

    def edit; end

    def create
      @committee_meeting = @committee.meetings.new(committee_meeting_params)
      @committee_meeting.save ? redirect_with('success') : render(:new)
    end

    def update
      @committee_meeting.update(committee_meeting_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @committee_meeting.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(committee_meeting_index_path(@committee), notice: t(".#{message}"))
    end

    def set_committee
      @committee = Unit.find(params[:committee_id])
    end

    def set_committee_meeting
      @committee_meeting = @committee.meetings.find(params[:id])
    end

    def committee_meeting_params
      params.require(:committee_meeting).permit(:meeting_no, :meeting_date, :year, :unit_id)
    end
  end
end
