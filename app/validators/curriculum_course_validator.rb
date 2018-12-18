# frozen_string_literal: true

class CurriculumCourseValidator < ActiveModel::Validator
  def validate(record)
    return unless record.curriculum_semester && record.course_id_changed?

    courses = record.curriculum_semester.curriculum.courses
    record.errors.add(:course, :taken) if courses.exists?(id: record.course_id)
  end
end
