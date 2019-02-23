# frozen_string_literal: true

class User < ApplicationRecord
  # virtual attributes
  attr_accessor :country

  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[id_number email],
    associated_against: { identities: %i[first_name last_name] },
    using: { tsearch: { prefix: true } }
  )

  # authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :lockable, :timeoutable

  # relations
  has_one_attached :avatar
  has_many :addresses, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :certifications, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :duties, through: :employees
  has_many :units, through: :employees
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties

  # validations
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :extension_number, allow_blank: true,
                               allow_nil: true,
                               length: { maximum: 8 },
                               numericality: { only_integer: true }
  validates :id_number, uniqueness: true, numericality: { only_integer: true }, length: { is: 11 }
  validates :linkedin, allow_blank: true, length: { maximum: 50 }
  validates :phone_number, length: { maximum: 255 },
                           allow_blank: true,
                           telephone_number: { country: proc { |record| record.country }, types: [:fixed_line] }
  validates :password, not_pwned: true
  validates :preferred_language, inclusion: { in: I18n.available_locales.map(&:to_s) }
  validates :skype, allow_blank: true, length: { maximum: 50 }
  validates :twitter, allow_blank: true, length: { maximum: 50 }
  validates :website, allow_blank: true, length: { maximum: 50 }
  validates_with EmailAddress::ActiveRecordValidator, field: :email
  validates_with ImageValidator, field: :avatar, if: proc { |a| a.avatar.attached? }

  # callbacks
  after_create_commit :build_address_information, if: proc { addresses.formal.empty? }
  after_create_commit :build_identity_information, if: proc { identities.formal.empty? }

  # store accessors
  store :profile_preferences, accessors: %i[
    extension_number
    linkedin
    orcid
    phone_number
    public_photo
    public_studies
    skype
    twitter
    website
  ], coder: JSON

  # permalinks
  extend FriendlyId
  friendly_id :permalink, use: :slugged

  def permalink
    username, domain = email.split('@') if email
    username if domain.eql?(Tenant.configuration.email.domain)
  end

  # send devise e-mails through active job
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  # custom methods
  def accounts
    (students + employees).flatten
  end

  def title
    employees.active.first.try(:title).try(:name)
  end

  def self.with_most_articles
    where.not(articles_count: 0).order('articles_count desc').limit(10)
  end

  def self.with_most_projects
    where.not(projects_count: 0).order('projects_count desc').limit(10)
  end

  private

  def build_address_information
    Kps::AddressSaveJob.perform_later(self)
  end

  def build_identity_information
    Kps::IdentitySaveJob.perform_later(self)
  end
end
