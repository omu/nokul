# frozen_string_literal: true

class ProspectiveStudent < ApplicationRecord
  # search
  include PgSearch::Model
  include DynamicSearch
  include Prospective

  pg_search_scope(
    :search,
    against: %i[id_number first_name last_name],
    using:   { tsearch: { prefix: true } }
  )

  search_keys :meb_status, :military_status, :obs_status, :unit_id, :student_entrance_type_id,
              :registered, :academic_term_id, :system_register_type, :archived

  # callbacks
  before_validation :normalize_attributes

  # enumerations
  enum additional_score: { handicapped: 1 }
  enum nationality: { turkish: 1, kktc: 2, foreign: 3 }
  enum placement_type: { general: 1, additional_score: 2 }
  enum system_register_type: { manual: 0, bulk: 1 }

  # relations
  belongs_to :academic_term
  belongs_to :high_school_type, optional: true
  belongs_to :language, optional: true
  belongs_to :student_entrance_type
  belongs_to :student_disability_type, optional: true
  belongs_to :unit
  belongs_to :user, optional: true, primary_key: :id_number, foreign_key: :id_number, inverse_of: :prospective_students

  # validations
  validates :additional_score, allow_nil: true, inclusion: { in: additional_scores.keys }
  validates :address, length: { maximum: 255 }
  validates :email, length: { maximum: 255 }
  validates :exam_score, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
  validates :expiry_date, presence: true
  validates :fathers_name, length: { maximum: 255 }
  validates :high_school_code, length: { maximum: 255 }
  validates :high_school_branch, length: { maximum: 255 }
  validates :high_school_graduation_year, allow_nil:    true,
                                          numericality: {
                                            only_integer:             true,
                                            greater_than_or_equal_to: 1910,
                                            less_than_or_equal_to:    2050
                                          }
  validates :home_phone, length: { maximum: 255 }
  validates :id_number, presence: true, uniqueness: { scope: %i[unit_id exam_score] }, length: { is: 11 }
  validates :meb_status, inclusion: { in: [true, false] }
  validates :military_status, inclusion: { in: [true, false] }
  validates :mothers_name, length: { maximum: 255 }
  validates :nationality, allow_nil: true, inclusion: { in: nationalities.keys }
  validates :obs_registered_program, length: { maximum: 255 }
  validates :obs_status, inclusion: { in: [true, false] }
  validates :place_of_birth, length: { maximum: 255 }
  validates :placement_rank, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :placement_score, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
  validates :placement_score_type, length: { maximum: 255 }
  validates :placement_type, allow_nil: true, inclusion: { in: placement_types.keys }
  validates :preference_order, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :registration_city, length: { maximum: 255 }
  validates :registered, inclusion: { in: [true, false] }
  validates :registration_district, length: { maximum: 255 }
  validates :state_of_education, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :system_register_type, inclusion: { in: system_register_types.keys }
  validates :top_student, inclusion: { in: [true, false] }
  validates :year, allow_nil:    false,
                   numericality: {
                     only_integer:             true,
                     greater_than_or_equal_to: 2010,
                     less_than_or_equal_to:    2100
                   }
  validates :online_registration_term_type, length: { maximum: 255 }

  validates_with ProspectiveStudentValidator, on: :update

  # scopes
  scope :registered, -> { where(registered: true) }

  # custom methods
  def can_permanently_register?
    military_status && obs_status && meb_status
  end

  def can_temporarily_register?
    military_status
  end

  def avatar
    return if id_number.blank?

    Rails.cache.fetch(self, expires_in: 10.days) {
      Xokul::Yoksis::Prospectives.photo(id_number)
    }
  end

  private

  # rubocop:disable Metrics/AbcSize
  def normalize_attributes
    self.first_name            = first_name.to_s.capitalize_turkish
    self.last_name             = last_name.to_s.upcase(:turkic)
    self.fathers_name          = fathers_name.to_s.capitalize_turkish
    self.mothers_name          = mothers_name.to_s.capitalize_turkish
    self.place_of_birth        = place_of_birth.to_s.capitalize_turkish
    self.registration_city     = registration_city.to_s.capitalize_turkish
    self.registration_district = registration_district.to_s.capitalize_turkish
  end
  # rubocop:enable Metrics/AbcSize
end
