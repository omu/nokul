class UndergraduateProgram < ApplicationRecord
  belongs_to :program, polymorphic: true
end
