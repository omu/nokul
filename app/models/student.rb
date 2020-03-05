# frozen_string_literal: true

class Student < ApplicationRecord
  # Ldap
  include LDAP::Trigger
  ldap_trigger :user

  # relations
  belongs_to :scholarship_type, optional: true
  belongs_to :user
  belongs_to :unit
  has_one :identity, dependent: :destroy
  has_many :calendars, -> { Calendar.active }, through: :unit
  has_many :curriculums, through: :unit
  has_many :semester_registrations, dependent: :destroy
  has_many :course_enrollments, through: :semester_registrations

  # scopes
  # TODO: Query will be organized according to activity status
  scope :active, -> { where(permanently_registered: true) }
  scope :not_scholarships, -> { where(scholarship_type_id: nil) }
  scope :scholarships, -> { where.not(scholarship_type_id: nil) }

  # validations
  validates :unit_id, uniqueness: { scope: %i[user] }
  # TODO: Will set equal_to: N, when we decide about student numbers
  validates :student_number, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :permanently_registered, inclusion: { in: [true, false] }
  validates :semester, numericality: { greater_than: 0 }
  validates :year, numericality: { greater_than_or_equal_to: 0 }

  # delegations
  delegate :addresses, to: :user
  delegate :name, to: :unit, prefix: true
  delegate :name, to: :scholarship_type, prefix: true, allow_nil: true

  # background jobs
  after_create_commit :build_identity_information, if: proc { identity.nil? }

  # custom methods
  # TODO: Temporary method will be organized according to student status in the future
  def active?
    permanently_registered?
  end

  def gpa
    return 0 if semester == 1

    student_number.to_s[-2..].to_f / 25
  end

  def current_registration
    @current_registration ||=
      semester_registrations.find_by(semester: semester) || semester_registrations.create
  end

  def scholarship?
    scholarship_type_id?
  end

  private

  def build_identity_information
    Kps::IdentitySaveJob.perform_later(user, id)
  end
end
