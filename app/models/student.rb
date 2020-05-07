# frozen_string_literal: true

class Student < ApplicationRecord
  # Ldap
  include LDAP::Trigger
  ldap_trigger :user

  # enums
  enum status: {
    active:     1,
    passive:    2,
    disengaged: 3,
    unenrolled: 4,
    graduated:  5
  }

  # relations
  belongs_to :entrance_type, class_name: 'StudentEntranceType'
  belongs_to :registration_term, class_name: 'AcademicTerm', optional: true
  belongs_to :scholarship_type, optional: true
  belongs_to :stage, class_name: 'StudentGrade', optional: true
  belongs_to :user
  belongs_to :unit
  has_one :identity, dependent: :destroy
  has_many :calendars, -> { Calendar.active }, through: :unit
  has_many :curriculums, through: :unit
  has_many :semester_registrations, dependent: :destroy
  has_many :course_enrollments, through: :semester_registrations
  has_many :tuition_debts, dependent: :destroy

  # scopes
  scope :exceeded, -> { where(exceeded_education_period: true) }
  scope :not_scholarships, -> { where(scholarship_type_id: nil) }
  scope :scholarships, -> { where.not(scholarship_type_id: nil) }
  scope :preparations, -> { where(stage: StudentGrade.preparation) }

  # validations
  validates :exceeded_education_period, inclusion: { in: [true, false] }
  validates :unit_id, uniqueness: { scope: %i[user] }
  validates :other_studentship, inclusion: { in: [true, false] }
  validates :permanently_registered, inclusion: { in: [true, false] }
  # TODO: Will set equal_to: N, when we decide about student numbers
  validates :preparatory_class, numericality: { only_integer:             true,
                                                greater_than_or_equal_to: 0,
                                                less_than_or_equal_to:    2 }
  validates :student_number, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :semester, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: statuses.keys }
  validates :year, numericality: { greater_than_or_equal_to: 0 }

  # delegations
  delegate :addresses, to: :user
  delegate :name, to: :stage, prefix: true, allow_nil: true
  delegate :name, to: :unit, prefix: true
  delegate :name, to: :scholarship_type, prefix: true, allow_nil: true

  # background jobs
  after_create_commit :build_identity_information, if: proc { identity.nil? }

  # custom methods
  def gpa
    return 0 if semester == 1

    student_number.to_s[-2..].to_f / 25
  end

  def current_registration
    @current_registration ||=
      semester_registrations.find_by(semester: semester) || semester_registrations.create
  end

  def preparation?
    Student.preparations.ids.include?(id)
  end

  def scholarship?
    scholarship_type_id?
  end

  def preparatory_class_repetition?
    preparatory_class.to_i >= 2
  end

  def prospective_student
    user.prospective_students.find_by(unit_id: unit_id)
  end

  private

  def build_identity_information
    Kps::IdentitySaveJob.perform_later(user, id)
  end
end
