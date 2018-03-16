class User < ApplicationRecord
  # devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  # validations
  validates :email, :id_number,
            presence: true, strict: true
  validates :email, :id_number,
            uniqueness: true, strict: true

  # STI helpers
  def self.types
    %w[Academician Employee Student]
  end

  scope :academicians, -> { where(type: 'Academician') }
  scope :employees, -> { where(type: 'Employee') }
  scope :students, -> { where(type: 'Student') }
end
