# frozen_string_literal: true

class ProspectiveStudent < ApplicationRecord
  # search
  include PgSearch
  include DynamicSearch

  pg_search_scope(
    :search,
    against: %i[id_number first_name last_name],
    using: { tsearch: { prefix: true } }
  )

  search_keys :meb_status, :military_status, :obs_status, :unit_id, :student_entrance_type_id

  # relations
  belongs_to :unit
  belongs_to :language, optional: true
  belongs_to :student_disability_type, optional: true
  belongs_to :high_school_type, optional: true
  belongs_to :student_entrance_type

  # validations
  validates :id_number, presence: true, uniqueness: { scope: %i[unit_id exam_score] }
  validates :gender, presence: true

  # callbacks
  before_create do
    self.first_name = first_name.titleize_tr
    self.last_name  = last_name.upcase_tr
    self.fathers_name = fathers_name.titleize_tr if fathers_name
    self.mothers_name = mothers_name.titleize_tr if mothers_name
    self.place_of_birth = place_of_birth.titleize_tr if place_of_birth
    self.registration_city = registration_city.titleize_tr if registration_city
    self.registration_district = registration_district.titleize_tr if registration_district
  end

  # enumerations
  enum gender: { male: 1, female: 2 }
  enum nationality: { turkish: 1, kktc: 2, foreign: 3 }
  enum placement_type: { general_score: 1, additional_score: 2 }
  enum additional_score: { handicapped: 1 }

  # custom methods
  def can_permanently_register?
    military_status && obs_status && meb_status
  end

  def can_temporarily_register?
    military_status
  end
end
