# frozen_string_literal: true

module CourseManagement
  class EnrolledCoursesController < ApplicationController
    def index
      student = current_user.students.last
      @curriculum = student.unit.curriculums.active.last
      @semesters = @curriculum.semesters.order(:year, :sequence).group_by(&:year)
    end
  end
end
