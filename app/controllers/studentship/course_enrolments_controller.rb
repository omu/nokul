# frozen_string_literal: true

module Studentship
  class CourseEnrolmentsController < ApplicationController
    before_action :set_student, only: :new
    before_action :set_curriculum, only: :new
    before_action :set_term, only: :new

    def index
      @students = current_user.students.includes(:unit)
    end

    def new
      @semesters = @curriculum.semesters.where(term: @term.term).order(:sequence)
    end

    private

    def redirect_with(message)
      redirect_to(:root, alert: t(".#{message}"))
    end

    def set_student
      student =
        current_user.students.find_by(id: params[:student_id]) ||
        current_user.students.first

      redirect_with('student_record_not_found') unless student

      @student = StudentDecorator.new(student)
    end

    def set_curriculum
      @curriculum = @student.curriculums.active.last
      redirect_with('active_curriculum_not_found') unless @curriculum
    end

    def set_term
      @term = AcademicTerm.active.last
      redirect_with('active_term_not_found') unless @term
    end
  end
end
