# frozen_string_literal: true

module Prospective
  extend ActiveSupport::Concern

  included do
    enum gender: { male: 1, female: 2 }

    validates :first_name, presence: true, length: { maximum: 255 }
    validates :gender, inclusion: { in: genders.keys }
    validates :last_name, presence: true, length: { maximum: 255 }
    validates :mobile_phone, length: { maximum: 255 }

    scope :archived, -> { where(archived: true) }
    scope :not_archived, -> { where(archived: false) }
  end
end
