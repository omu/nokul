# frozen_string_literal: true

class YoksisResponse < ApplicationRecord
  # validations
  validates :name, presence: true
  validates :endpoint, presence: true
  validates :action, presence: true
  validates :sha1, presence: true, uniqueness: true, length: { is: 40 }
end
