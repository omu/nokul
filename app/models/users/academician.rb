# frozen_string_literal: true

class Academician < User
  # relations
  has_many :responsibilities, foreign_key: 'user_id'
  has_many :positions, through: :responsibilities
end
