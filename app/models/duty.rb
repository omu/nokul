# frozen_string_literal: true

class Duty < ApplicationRecord
  # Ldap
  include LDAP::Trigger
  ldap_trigger ->(obj) { obj.employee.user }

  # enums
  enum article: {
    internal:             1,
    foreign:              2,
    long_term_temporary:  3,
    short_term_temporary: 4,
    public_institution:   5,
    lecturer_education:   6
  }

  # relations
  belongs_to :employee
  belongs_to :unit
  has_many :positions, dependent: :destroy
  has_many :administrative_functions, through: :positions

  # validations
  validates :article, allow_nil: true, inclusion: { in: articles.keys }
  validates :temporary, inclusion: { in: [true, false] }
  validates :start_date, presence: true
  validates :unit_id, uniqueness: { scope: %i[employee start_date] }
  validates_with DutyValidator

  # arel tables
  duties = Duty.arel_table

  # scopes
  scope :temporary, -> { where(temporary: true) }
  scope :tenure, -> { where(temporary: false) }
  scope :active, -> { where(duties[:end_date].gt(Time.zone.today).or(duties[:end_date].eq(nil))) }

  # delegations
  delegate :name, to: :unit, prefix: true

  # custom methods
  def active?
    end_date.nil? || end_date.future?
  end
end
