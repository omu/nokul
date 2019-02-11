# frozen_string_literal: true

class CourseEvaluationTypeValidator < ActiveModel::Validator
  def validate(record)
    @evaluation_type = record
    assessment_methods(record.course_assessment_methods)
    check_percentage(@assessments.map(&:percentage))
  end

  def check_percentage(percentages)
    return if percentages.sum.equal?(100)

    @evaluation_type.errors[:base] << message('invalid_percentages')
  end

  def assessment_methods(assessment_methods)
    @assessments =
      assessment_methods.map { |method| method unless method.marked_for_destruction? }.compact
  end

  private

  def message(key)
    I18n.t(key, scope: %i[validators course_evaluation_type])
  end
end
