class Department < ApplicationRecord
  belongs_to :unit, polymorphic: true
  has_many :undergraduate_programs, as: :program
end
