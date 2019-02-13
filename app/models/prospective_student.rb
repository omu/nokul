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

  search_keys :meb_status, :military_status, :obs_status, :unit_id, :student_entrance_type_id, :registered

  # enumerations
  enum gender: { male: 1, female: 2 }
  enum nationality: { turkish: 1, kktc: 2, foreign: 3 }
  enum placement_type: { general_score: 1, additional_score: 2 }
  enum additional_score: { handicapped: 1 }

  # relations
  belongs_to :unit
  belongs_to :language, optional: true
  belongs_to :student_disability_type, optional: true
  belongs_to :high_school_type, optional: true
  belongs_to :student_entrance_type

  # validations
  validates :id_number, presence: true, uniqueness: { scope: %i[unit_id exam_score] },
                        numericality: { only_integer: true },
                        length: { minimum: 5, maximum: 11 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :fathers_name, length: { maximum: 255 }
  validates :mothers_name, length: { maximum: 255 }
  validates :gender, inclusion: { in: genders.keys }
  validates :nationality, allow_nil: true, inclusion: { in: nationalities.keys }
  validates :place_of_birth, length: { maximum: 255 }
  validates :registration_city, length: { maximum: 255 }
  validates :registration_district, length: { maximum: 255 }
  validates :high_school_code, length: { maximum: 255 }
  validates :high_school_branch, length: { maximum: 255 }
  validates :state_of_education, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :high_school_graduation_year, allow_nil: true,
                                          numericality: {
                                            only_integer: true,
                                            greater_than_or_equal_to: 1910,
                                            less_than_or_equal_to: 2050
                                          }
  validates :placement_type, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :exam_score, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
  validates :address, length: { maximum: 255 }
  validates :home_phone, length: { maximum: 255 }
  validates :mobile_phone, length: { maximum: 255 }
  validates :email, length: { maximum: 255 }
  validates :top_student, inclusion: { in: [true, false] }
  validates :placement_score, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }
  validates :placement_rank, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :preference_order, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :placement_score_type, length: { maximum: 255 }
  validates :additional_score, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :meb_status, inclusion: { in: [true, false] }
  validates :military_status, inclusion: { in: [true, false] }
  validates :obs_status, inclusion: { in: [true, false] }
  validates :registered, inclusion: { in: [true, false] }
  validates :obs_registered_program, length: { maximum: 255 }

  # callbacks
  before_create do
    self.first_name = first_name.capitalize_turkish
    self.last_name  = last_name.upcase(:turkic)
    self.fathers_name = fathers_name.capitalize_turkish if fathers_name
    self.mothers_name = mothers_name.capitalize_turkish if mothers_name
    self.place_of_birth = place_of_birth.capitalize_turkish if place_of_birth
    self.registration_city = registration_city.capitalize_turkish if registration_city
    self.registration_district = registration_district.capitalize_turkish if registration_district
  end

  # custom methods
  def can_permanently_register?
    military_status && obs_status && meb_status
  end

  def can_temporarily_register?
    military_status
  end
end
