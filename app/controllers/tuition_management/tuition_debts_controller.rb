# frozen_string_literal: true

module TuitionManagement
  class TuitionDebtsController < ApplicationController
    include SearchableModule

    before_action :set_tuition_debt, only: %i[edit update destroy]
    before_action :authorized?

    def index
      tuition_debts =
        TuitionDebt.includes(:academic_term, student: %i[unit user]).joins(:student).where(
          params[:unit_id].present? ? { students: { unit_id: params[:unit_id] } } : {}
        )

      @pagy, @tuition_debts = pagy(tuition_debts.dynamic_search(search_params(TuitionDebt)))
    end

    def new
      @tuition_debt = TuitionDebt.new
    end

    def create
      @tuition_debt = TuitionDebt.new(tuition_debt_params)
      @tuition_debt.save ? redirect_to(:tuition_debts, notice: t('.success')) : render(:new)
    end

    def edit; end

    def update
      @tuition_debt.update(tuition_debt_params) ? redirect_to(:tuition_debts, notice: t('.success')) : render(:edit)
    end

    def create_with_service
      Debt::TuitionDebtJob.perform_later(params.dig(:tuition_debt, :unit_ids),
                                         params.dig(:tuition_debt, :academic_term_id),
                                         params.dig(:tuition_debt, :due_date))
      redirect_to(tuition_debts_path, notice: t('.will_update'))
    end

    def destroy
      return redirect_to(:tuition_debts, notice: t('.success')) if @tuition_debt.destroy

      redirect_to(:tuition_debts, alert: t('.warning'))
    end

    private

    def set_tuition_debt
      @tuition_debt = TuitionDebt.find(params[:id])
    end

    def authorized?
      authorize([:tuition_management, @tuition_debt || TuitionDebt])
    end

    def tuition_debt_params
      params.require(:tuition_debt).permit(
        :student_id, :academic_term_id, :amount, :description, :type, :paid, :due_date
      )
    end
  end
end
