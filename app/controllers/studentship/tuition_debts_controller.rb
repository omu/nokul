# frozen_string_literal: true

module Studentship
  class TuitionDebtsController < ApplicationController
    before_action :set_student

    def index
      @debts = @student.tuition_debts
    end
    
    private

    def set_student
      @student = current_user.students.find(params[:student_id])
    end
  end
end
