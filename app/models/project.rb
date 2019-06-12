# frozen_string_literal: true

class Project < ApplicationRecord
  self.inheritance_column = nil

  # enums
  enum status: {
    completed:  1,
    continuing: 2,
    deferred:   3,
    pending:    4
  }

  enum activity: { passive: 0, active: 1 }
  enum scope: { national: 0, international: 1 }

  # relations
  belongs_to :user, counter_cache: true

  # validations
  validates :yoksis_id, uniqueness:   { scope: %i[user_id status] },
                        numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, length: { maximum: 65_535 }
  validates :subject, length: { maximum: 65_535 }
  validates :budget, length: { maximum: 255 }
  validates :duty, length: { maximum: 255 }
  validates :type, length: { maximum: 255 }
  validates :currency, length: { maximum: 255 }
  validates :title, length: { maximum: 255 }
  validates :status, allow_nil: true, inclusion: { in: statuses.keys }
  validates :activity, allow_nil: true, inclusion: { in: activities.keys }
  validates :scope, allow_nil: true, inclusion: { in: scopes.keys }
  validates :incentive_point, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
end
