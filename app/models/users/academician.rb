class Academician < User
  has_many :responsibilities
  has_many :positions, through: :responsibilities
end
