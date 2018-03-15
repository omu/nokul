class Employee < User
  has_many :responsibilities, foreign_key: 'user_id'
  has_many :positions, through: :responsibilities
end
