# frozen_string_literal: true

module TuitionManagement
  class TuitionDebtsController < ApplicationController
    include SearchableModule

    before_action :set_tuition_debt, only: %i[edit update destroy]

    def index
      tuition_debts =
        TuitionDebt.includes(:academic_term, :unit, student: :user).joins(:unit).where(
          params[:unit_id].present? ? { units: { id: params[:unit_id] } } : {}
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
                                         params.dig(:tuition_debt, :academic_term_id))
      redirect_to(tuition_debts_path, notice: t('.will_update'))
    end

    def destroy
      tuition_debt = TuitionDebt.find(params[:id])
      return redirect_to(:tuition_debts, notice: t('.success')) if tuition_debt.destroy

      redirect_to(:tuition_debts, alert: t('.warning'))
    end

    private

    def set_tuition_debt
      @tuition_debt = TuitionDebt.find(params[:id])
    end

    def tuition_debt_params
      params.require(:tuition_debt).permit(:student_id, :academic_term_id, :amount, :description, :type, :paid)
    end
  end
end
