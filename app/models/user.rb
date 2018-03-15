class User < ApplicationRecord
  # Include default devise modules. Others available are: :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable
end
