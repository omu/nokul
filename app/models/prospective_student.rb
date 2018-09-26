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
    self.first_name = first_name.capitalize_all
    self.last_name  = last_name.upcase_tr
    self.fathers_name = fathers_name.capitalize_all if fathers_name
    self.mothers_name = mothers_name.capitalize_all if mothers_name
    self.place_of_birth = place_of_birth.capitalize_all if place_of_birth
    self.registration_city = registration_city.capitalize_all if registration_city
    self.registration_district = registration_district.capitalize_all if registration_district
  end

  # enumerations
  enum gender: { male: 1, female: 2 }
  enum nationality: { turkish: 1, kktc: 2, foreign: 3 }
  enum placement_type: { general: 1, additional_score: 2 }
  enum additional_score: { handicapped: 1 }
end
