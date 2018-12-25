# frozen_string_literal: true

class Student < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :unit
  has_one :identity, dependent: :destroy

  # validations
  validates :unit_id, uniqueness: { scope: %i[user] }
  # TODO: Will set equal_to: N, when we decide about student numbers
  validates :student_number, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :permanently_registered, inclusion: { in: [true, false] }

  # delegations
  delegate :addresses, to: :user

  # background jobs
  after_create_commit :build_identity_information, if: proc { identity.nil? }

  def build_identity_information
    Kps::IdentitySaveJob.perform_later(user, id)
  end
end
