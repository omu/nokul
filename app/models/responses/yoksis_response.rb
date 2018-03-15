class YoksisResponse < ApplicationRecord
  # validations
  validates :name, :endpoint, :action, :sha1,
            presence: true, strict: true
end
