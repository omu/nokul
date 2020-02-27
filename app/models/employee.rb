# frozen_string_literal: true

class Employee < ApplicationRecord
  # Ldap
  include LDAP::Trigger
  ldap_trigger :user, attributes: %i[title_id active staff_number]

  # relations
  belongs_to :title
  belongs_to :user
  has_many :duties, dependent: :destroy
  has_many :units, through: :duties
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties
  has_many :available_course_lecturers, foreign_key: :lecturer_id, inverse_of: :lecturer, dependent: :destroy
  has_many :coordinatorships, class_name: 'AvailableCourse', foreign_key: :coordinator_id,
                              inverse_of: :coordinator, dependent: :destroy

  # validations
  validates :active, inclusion: { in: [true, false] }
  validates :staff_number, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :title_id, uniqueness: { scope: %i[user active] }
  validates_with EmployeeValidator

  # delegations
  delegate :identities, to: :user
  delegate :addresses, to: :user
  delegate :name, to: :title, prefix: true

  # scopes
  scope :active, -> { where(active: true) }
  scope :passive, -> { where(active: false) }
  scope :academic, -> { joins(:title).where('titles.branch = ?', 'ÖE') }
  scope :administrative, -> { joins(:title).where('titles.branch != ?', 'ÖE') }

  # custom methods
  def academic?
    title.branch.eql?('ÖE')
  end

  def given_courses
    AvailableCourse.joins(groups: :lecturers)
                   .where('coordinator_id = ? OR lecturer_id = ?', id, id)
  end

  def coordinator_of?(available_course)
    id == available_course.coordinator_id
  end
end
