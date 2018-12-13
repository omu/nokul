# frozen_string_literal: true

class AvailableCourseLecturerValidator < ActiveModel::Validator
  def validate(record)
    lecturers = record.group.lecturers.where.not(id: record)
    return unless record.coordinator && lecturers.pluck(:coordinator).any?

    record.errors[:coordinator] << I18n.t('coordinator', scope: %i[validators available_course_lecturer])
  end
end
