# frozen_string_literal: true

class User < ApplicationRecord
  # authorizations
  include Patron::Roleable
  include Patron::Scopable

  # Ldap
  include LDAP::Trigger
  ldap_trigger :self, attributes: %i[
    id_number
    email
    preferred_language
    activated
  ]

  # virtual attributes
  attr_accessor :country

  # search
  include PgSearch::Model
  pg_search_scope(
    :search,
    against:            %i[id_number email],
    associated_against: { identities: %i[first_name last_name] },
    using:              { tsearch: { prefix: true } }
  )

  # authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :trackable, :validatable, :lockable, :timeoutable
  devise :omniauthable, omniauth_providers: %i[openid_connect]

  # relations
  has_one_attached :avatar
  has_many :academic_credentials, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :certifications, dependent: :destroy
  has_many :papers, dependent: :destroy
  has_many :education_informations, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :ldap_entities, dependent: :destroy
  has_many :duties, through: :employees
  has_many :units, through: :employees
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties
  has_many :prospective_students, primary_key: :id_number,
                                  foreign_key: :id_number,
                                  dependent:   :nullify,
                                  inverse_of:  :user
  has_many :prospective_employees, primary_key: :id_number,
                                   foreign_key: :id_number,
                                   dependent:   :nullify,
                                   inverse_of:  :user
  has_one :current_employee, -> { active }, class_name: 'Employee', inverse_of: :user

  # validations
  validates :disability_rate, numericality: {
    only_integer:             true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to:    100
  }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, 'valid_email_2/email': {
    mx:                     true,
    disposable:             true,
    disallow_subaddressing: true,
    message:                I18n.t('errors.invalid_email')
  }
  validates :extension_number, allow_blank:  true,
                               length:       { maximum: 8 },
                               numericality: { only_integer: true }
  validates :id_number, uniqueness: true, numericality: { only_integer: true }, length: { is: 11 }
  validates :linkedin, allow_blank: true, length: { maximum: 50 }
  validates :mobile_phone, allow_blank:      true,
                           length:           { maximum: 255 },
                           telephone_number: { country: proc { |record| record.country }, types: [:mobile] }
  validates :fixed_phone, allow_blank:      true,
                          length:           { maximum: 255 },
                          telephone_number: { country: proc { |record| record.country }, types: [:fixed_line] }
  validates :password, not_pwned: true
  validates :preferred_language, inclusion: { in: I18n.available_locales.map(&:to_s) }
  validates :skype, allow_blank: true, length: { maximum: 50 }
  validates :twitter, allow_blank: true, length: { maximum: 50 }
  validates :website, allow_blank: true, length: { maximum: 50 }
  validates_with ImageValidator, field: :avatar, if: proc { |a| a.avatar.attached? }

  # callbacks
  after_create_commit :build_address_information, if: proc { addresses.formal.empty? }
  after_create_commit :build_identity_information, if: proc { identities.formal.empty? }
  before_save :update_password_changed_at

  # scopes
  scope :activated, -> { where(activated: true) }

  # store accessors
  store :profile_preferences, accessors: %i[
    extension_number
    linkedin
    orcid
    fixed_phone
    public_photo
    public_studies
    skype
    twitter
    website
  ], coder: JSON

  # permalinks
  extend FriendlyId
  friendly_id :permalink, use: :slugged

  def self.from_omniauth(auth)
    find_or_initialize_by(id_number: auth.uid)
  end

  def permalink
    username, domain = email.split('@') if email
    username if domain.eql?(Tenant.configuration.email.domain)
  end

  # send devise e-mails through active job
  def send_devise_notification(notification, *args)
    devise_mailer.public_send(notification, self, *args).deliver_later
  end

  # custom methods
  def accounts
    Patron::Account.call(self)
  end

  def title
    employees.active.first.try(:title).try(:name)
  end

  def employee?
    employees.active.exists?
  end

  def student?
    students.active.exists?
  end

  def academic?
    employees.active.academic.exists?
  end

  def disabled?
    disability_rate.positive?
  end

  def self.with_most_articles
    where.not(articles_count: 0).order('articles_count desc').limit(10)
  end

  def self.with_most_projects
    where.not(projects_count: 0).order('projects_count desc').limit(10)
  end

  def active_for_authentication?
    super && activated?
  end

  def inactive_message
    activated? ? super : :account_not_activated
  end

  private

  def build_address_information
    Kps::AddressSaveJob.perform_later(self)
  end

  def build_identity_information
    Kps::IdentitySaveJob.perform_later(self)
  end

  def update_password_changed_at
    return unless (new_record? || encrypted_password_changed?) && !password_changed_at_changed?

    self.password_changed_at = Time.zone.now
  end
end
