# frozen_string_literal: true

class Project < ApplicationRecord
  self.inheritance_column = nil

  # enums
  enum status: {
    completed: 1,
    continuing: 2,
    deferred: 3,
    pending: 4
  }

  enum activity: { passive: 0, active: 1 }
  enum scope: { national: 0, international: 1 }

  # relations
  belongs_to :user, counter_cache: true

  # validations
  validates :yoksis_id, presence: true, uniqueness: { scope: %i[user_id status] },
                        numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, length: { maximum: 65_535 }
  validates :subject, allow_nil: true, length: { maximum: 65_535 }
  validates :budget, allow_nil: true, length: { maximum: 255 }
  validates :duty, allow_nil: true, length: { maximum: 255 }
  validates :type, allow_nil: true, length: { maximum: 255 }
  validates :currency, allow_nil: true, length: { maximum: 255 }
  validates :title, allow_nil: true, length: { maximum: 255 }
  validates :status, allow_nil: true, inclusion: { in: statuses.keys }
  validates :activity, allow_nil: true, inclusion: { in: activities.keys }
  validates :scope, allow_nil: true, inclusion: { in: scopes.keys }
  validates :incentive_point, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
end
