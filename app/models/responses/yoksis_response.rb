# frozen_string_literal: true

class YoksisResponse < ApplicationRecord
  # validations
  validates :name, :endpoint, :action, :sha1,
            presence: true
  validates :sha1,
            uniqueness: true
end
