# frozen_string_literal: true

module CourseManagement
  class EnrolledCoursesController < ApplicationController
    def index
      student = current_user.students.last
      term = AcademicTerm.active.last.try(:term)
      @curriculum = student.unit.curriculums.active.last
      @semesters = @curriculum.semesters.where(term: term).order(:year, :sequence)
    end
  end
end
