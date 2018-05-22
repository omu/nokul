# frozen_string_literal: true

class Student < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :unit
  has_one :identity, dependent: :destroy

  # validations
  validates :student_number, presence: true, uniqueness: true

  # background jobs
  after_create_commit :build_identity_information, if: proc { identity.nil? }

  def build_identity_information
    KpsIdentityCreateJob.perform_later(user, id)
  end
end
