# frozen_string_literal: true

class CalendarTitleType < ApplicationRecord
  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :type, class_name: 'CalendarType'
  belongs_to :title, class_name: 'CalendarTitle'

  # validations
  validates :type, uniqueness: { scope: :title }
  validates :status, inclusion: { in: statuses.keys }
end
