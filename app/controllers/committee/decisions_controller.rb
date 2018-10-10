# frozen_string_literal: true

module Committee
  class DecisionsController < ApplicationController
    before_action :set_committee_and_agenda
    before_action :setup_decision, only: %i[edit update destroy]

    def new
      @decision = @agenda.build_decision
    end

    def create
      @decision = @agenda.build_decision(decision_params)
      @decision.save ? redirect_with('success') : render(:new)
    end

    def edit; end

    def update
      @decision.update(decision_params) ? redirect_with('success') : render(:edit)
    end

    def destroy
      @decision.destroy ? redirect_with('success') : redirect_with('warning')
    end

    private

    def redirect_with(message)
      redirect_to(committee_meeting_path(@committee, @agenda.committee_meeting), notice: t(".#{message}"))
    end

    def set_committee_and_agenda
      @committee = Unit.committees.find(params[:committee_id])
      @agenda = @committee.meeting_agendas.find(params[:meeting_agenda_id])
    end

    def setup_decision
      @decision = @agenda.decision
    end

    def decision_params
      params.require(:committee_decision).permit(:description, :decision_no)
    end
  end
end
