# frozen_string_literal: true

class CalendarTitleType < ApplicationRecord
  # relations
  belongs_to :type, class_name: 'CalendarType'
  belongs_to :title, class_name: 'CalendarTitle'

  # validations
  validates :type, uniqueness: { scope: :title }
  validates :active, inclusion: { in: [true, false] }
end
