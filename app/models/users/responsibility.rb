class Responsibility < ApplicationRecord
  belongs_to :user
  belongs_to :unit
  belongs_to :position
end
