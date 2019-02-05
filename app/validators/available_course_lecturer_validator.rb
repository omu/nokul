# frozen_string_literal: true

class AvailableCourseLecturerValidator < ActiveModel::Validator
  def validate(record)
    lecturers(record.group.lecturers.reject { |lecturer| lecturer.equal?(record) })

    return if not_exist_coordinator?(record, @lecturers) || any_coordinator?(record, @lecturers)

    record.errors[:coordinator] << I18n.t('coordinator', scope: %i[validators available_course_lecturer])
  end

  def lecturers(course_lecturers)
    @lecturers =
      course_lecturers.map { |lecturer| lecturer unless lecturer.marked_for_destruction? }.compact
  end

  private

  def any_coordinator?(record, lecturers)
    !record.coordinator && lecturers.map(&:coordinator).any?
  end

  def not_exist_coordinator?(record, lecturers)
    record.coordinator && lecturers.map(&:coordinator).none?
  end
end
