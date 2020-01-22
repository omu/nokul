# frozen_string_literal: true

class Target < ApplicationRecord
  belongs_to :course
  belongs_to :icc

  validates :course_id, presence: true
  validates :icc_id, presence: true, uniqueness: { scope: :course_id }
end
