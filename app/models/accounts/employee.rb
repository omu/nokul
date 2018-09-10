# frozen_string_literal: true

class Employee < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :title
  has_many :duties, dependent: :destroy
  has_many :units, through: :duties
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties

  # validations
  validates :title_id, uniqueness: { scope: %i[user active] }
  validates :active, inclusion: { in: [true, false] }
  validates_with EmployeeValidator

  # delegations
  delegate :identities, to: :user
  delegate :addresses, to: :user
  delegate :name, to: :title, prefix: true

  # scopes
  scope :active, -> { where(active: true) }
  scope :passive, -> { where(active: false) }
  scope :academic, -> { joins(:title).where('titles.branch = ?', 'ÖE') }

  # custom methods
  def academic?
    title.branch.eql?('ÖE')
  end
end
