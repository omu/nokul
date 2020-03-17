# frozen_string_literal: true

class StudentGrade < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations

  # relations
  has_many :students, dependent: :nullify

  # scopes
  scope :course, -> { where(code: 9) }
  scope :preparation, -> { where(code: 1) }
  scope :phd_qualify, -> { where(code: 11) }
  scope :project, -> { where(code: 14) }
  scope :thesis, -> { where(code: 10) }
end
