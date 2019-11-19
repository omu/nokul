# frozen_string_literal: true

class Student < ApplicationRecord
  ECTS = 30

  # Ldap
  include LDAP::Trigger
  ldap_trigger :user

  # relations
  belongs_to :user
  belongs_to :unit
  has_one :identity, dependent: :destroy
  has_many :calendars, -> { Calendar.active }, through: :unit
  has_many :curriculums, through: :unit
  has_many :course_enrollments, dependent: :destroy

  # scopes
  # TODO: Query will be organized according to activity status
  scope :active, -> { where(permanently_registered: true) }

  # validations
  validates :unit_id, uniqueness: { scope: %i[user] }
  # TODO: Will set equal_to: N, when we decide about student numbers
  validates :student_number, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :permanently_registered, inclusion: { in: [true, false] }
  validates :semester, numericality: { greater_than: 0 }
  validates :year, numericality: { greater_than_or_equal_to: 0 }

  # delegations
  delegate :addresses, to: :user

  # background jobs
  after_create_commit :build_identity_information, if: proc { identity.nil? }

  # custom methods
  def fake_gpa
    student_number.to_s[-2..-1].to_f / 25
  end

  def plus_ects
    case fake_gpa
    when 1.8..2.49 then 6
    when 2.5..2.99 then 10
    when 3.0..3.49 then 12
    when 3.5..4 then 15
    else 0
    end
  end

  def selected_ects
    @selected_ects ||= semester_enrollments.sum(:ects).to_i
  end

  def selectable_ects
    @selectable_ects ||= ECTS + plus_ects - selected_ects
  end

  def semester_enrollments
    @semester_enrollments ||=
      course_enrollments.where(semester: semester)
                        .includes(available_course: [curriculum_course: %i[course curriculum_semester]])
  end

  def ensure_dropable(available_course)
    sequence = available_course.curriculum_course.curriculum_semester.sequence
    return translate('must_drop_first') if max_sequence > sequence
  end

  def ensure_addable(available_course)
    if available_course.type == 'elective' && enrolled_in_group_of?(available_course)
      return translate('already_enrolled_at_group')
    end

    return translate('not_enough_ects') if selectable_ects < available_course.ects
    return translate('quota_full') if available_course.quota_full?
  end

  private

  def build_identity_information
    Kps::IdentitySaveJob.perform_later(user, id)
  end

  def max_sequence
    @max_sequence ||= semester_enrollments.pluck(:sequence).max
  end

  def enrolled_in_group_of?(available_course)
    (semester_enrollments.pluck(:available_course_id) & available_course.group_courses.pluck(:id)).any?
  end

  def translate(key, params = {})
    I18n.t("studentship.course_enrollments.new.#{key}", params)
  end
end
