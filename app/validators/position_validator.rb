# frozen_string_literal: true

class PositionValidator < ActiveModel::Validator
  def validate(record)
    @position = record
    @positions = record.duty.employee.user.positions.where.not(id: @position.id)

    date_validation if @position.start_date? && @position.end_date?
    restrict_positions if @position.active?
  end

  def date_validation
    @position.errors[:end_date] << message('invalid_end_date') if @position.end_date < @position.start_date
  end

  def restrict_positions
    repetitive_positions = @positions.active.where(
      administrative_function: @position.administrative_function,
      duty: @position.duty
    )
    add_to_base_error('multiple_active_repetitive') if repetitive_positions.any?
  end

  private

  def message(key)
    I18n.t(key, scope: %i[validators position])
  end

  def add_to_base_error(key)
    @position.errors[:base] << message(key)
  end
end
