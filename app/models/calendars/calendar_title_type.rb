# frozen_string_literal: true

class CalendarTitleType < ApplicationRecord
  # relations
  belongs_to :type, class_name: 'CalendarType'
  belongs_to :title, class_name: 'CalendarTitle'

  # validations
  validates :type_id, uniqueness: { scope: :title_id }

  # enums
  enum status: { active: 0, passive: 1 }
end
