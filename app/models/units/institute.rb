class Institute < ApplicationRecord
  belongs_to :university
  has_many :master_programs
  has_many :doctoral_programs
  has_many :proficiency_in_art_programs
  has_many :interdisciplinary_departments
end
