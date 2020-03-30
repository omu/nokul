# frozen_string_literal: true

module TuitionManagement
  class TuitionDebtsController < ApplicationController
    def index
      @tuition_debts = TuitionDebt.includes(:academic_term, student: %i[unit user])
    end

    def new
      @tuition_debt = TuitionDebt.new
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

    def tuition_debt_params
      params.require(:tuition_debt).permit(:student_id, :academic_term_id, :unit_tuition_id, :amount, :description)
    end
  end
end
