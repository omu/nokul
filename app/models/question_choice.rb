# frozen_string_literal: true

class QuestionChoice < ApplicationRecord
  belongs_to :question

  validates :content, length: { maximum: 500 }

  before_save lambda {
    self.content = content.squish if content.presence
  }
end
