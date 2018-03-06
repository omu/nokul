class Faculty < ApplicationRecord
  belongs_to :university
  has_many :departments, as: :unit
  has_many :undergraduate_programs, as: :program
end
