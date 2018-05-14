# frozen_string_literal: true

class CalendarTitleType < ApplicationRecord
  # relations
  belongs_to :type, class_name: 'CalendarType'
  belongs_to :title, class_name: 'CalendarTitle'

  # validations
  validates :type, uniqueness: { scope: :title }

  # callbacks
  around_save :catch_uniqueness_exception

  # enums
  enum status: { active: 0, passive: 1 }

  private

  def catch_uniqueness_exception
    yield
  rescue ActiveRecord::RecordNotUnique
    errors.add(:type, 'title is already taken')
  end
end
