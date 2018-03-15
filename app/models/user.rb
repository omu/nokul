class User < ApplicationRecord
  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  # validations
  validates :email,
            presence: true, strict: true
  validates :email,
            uniqueness: true, strict: true

  # STI helpers
  def self.types
    %w[Academician Employee Student]
  end

  scope :academicians, -> { where(type: 'Academician') }
  scope :employees, -> { where(type: 'Employee') }
  scope :students, -> { where(type: 'Student') }
end
