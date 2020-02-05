# frozen_string_literal: true

class DisabilityValidator < ActiveModel::Validator
  def validate(record)
    @user = record

    @user.errors[:base] << I18n.t('.validators.disability.disability_error') unless both_empty? || both_full?
  end

  private

  def both_empty?
    !@user.disability_type_id? && @user.disability_rate&.zero?
  end

  def both_full?
    @user.disability_type_id? && !@user.disability_rate&.zero?
  end
end
