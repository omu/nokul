# frozen_string_literal: true

module Studentship
  class TuitionDebtsController < ApplicationController
    before_action :set_student
    before_action :authorized?

    def index
      @debts = @student.tuition_debts.includes(:academic_term).order(:due_date)
    end

    private

    def set_student
      @student = current_user.students.find(params[:student_id])
    end

    def authorized?
      authorize(@student, policy_class: Studentship::TuitionDebtPolicy)
    end
  end
end
