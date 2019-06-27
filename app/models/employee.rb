# frozen_string_literal: true

class Employee < ApplicationRecord
  # Ldap
  include LdapSyncTrigger

  ldap_sync_trigger :user, attributes: %i[title_id active]

  # relations
  belongs_to :title
  belongs_to :user
  has_many :duties, dependent: :destroy
  has_many :units, through: :duties
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties
  has_many :available_course_lecturers, foreign_key: :lecturer_id, inverse_of: :lecturer, dependent: :destroy

  # validations
  validates :active, inclusion: { in: [true, false] }
  validates :staff_number, presence: true, uniqueness: { scope: %i[active] }, length: { maximum: 255 }
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
end
