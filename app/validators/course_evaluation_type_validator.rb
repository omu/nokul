# frozen_string_literal: true

class CourseEvaluationTypeValidator < ActiveModel::Validator
  def validate(record)
    @evaluation_type = record
    check_percentage(@evaluation_type.course_assessment_methods.map(&:percentage))
  end

  def check_percentage(percentages)
    return if percentages.sum.equal?(100)

    @evaluation_type.errors[:base] << message('invalid_percentages')
  end

  private

  def message(key)
    I18n.t(key, scope: %i[validators course_evaluation_type])
  end
end
