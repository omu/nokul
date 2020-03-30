# frozen_string_literal: true

module TuitionManagement
  class TuitionDebtsController < ApplicationController
    def index
      @tuition_debts = TuitionDebt.includes(:academic_term, student: %i[unit user])
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
