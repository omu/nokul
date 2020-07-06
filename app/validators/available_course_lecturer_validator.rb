# frozen_string_literal: true

class AvailableCourseLecturerValidator < ActiveModel::Validator
  def validate(record)
    @lecturer = record
    check_lecturer_uniqueness(lecturers(record.group.lecturers).map(&:lecturer_id))
    check_coordinator(record, lecturers(record.group.lecturers.reject { |lecturer| lecturer.equal?(record) }))
  end

  private

  def lecturers(course_lecturers)
    course_lecturers.reject(&:marked_for_destruction?)
  end

  def check_lecturer_uniqueness(lecturer_ids)
    return if lecturer_ids.eql?(lecturer_ids.uniq)

    @lecturer.errors[:lecturer_id] << I18n.t('lecturer_uniqueness', scope: %i[validators available_course_lecturer])
  end

  def check_coordinator(record, lecturers)
    return if none_coordinator?(record, lecturers) || any_coordinator?(record, lecturers)

    @lecturer.errors[:coordinator] << I18n.t('coordinator', scope: %i[validators available_course_lecturer])
  end

  def any_coordinator?(record, lecturers)
    !record.coordinator && lecturers.map(&:coordinator).any?
  end

  def none_coordinator?(record, lecturers)
    record.coordinator && lecturers.map(&:coordinator).none?
  end
end
