# frozen_string_literal: true

class LearningOutcomeValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @micros = record.micros
    @codes = @micros.map(&:code).push(record.code)
    return if codes_unique?

    add_error_message_to_invalid_records
    @record.errors.add(:base, message('invalid_code'))
  end

  def codes_unique?
    @codes.uniq.size == @codes.size
  end

  def add_error_message_to_invalid_records
    invalid_codes = @codes.select { |code| @codes.count(code) > 1 }.uniq

    @micros.each do |learning_outcome|
      learning_outcome.errors.add(:code, message('must_be_uniq')) if invalid_codes.include?(learning_outcome.code)
    end

    @record.errors.add(:code, message('must_be_uniq')) if invalid_codes.include?(@record.code)
  end

  private

  def message(key)
    I18n.t(key, scope: %i[validators learning_outcome])
  end
end
