# frozen_string_literal: true

class Question < ApplicationRecord
  enum status: [:draft, :editor, :master, :approve]

  belongs_to :icc
  belongs_to :answer, foreign_key: :answer_id, class_name: 'QuestionChoice'
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  belongs_to :editor, foreign_key: :editor_id, class_name: 'User'
  belongs_to :master, foreign_key: :master_id, class_name: 'User'
  belongs_to :parent, foreign_key: :parent_id, class_name: 'Question'
  belongs_to :unit
  belongs_to :source_book

  has_many :question_choices, dependent: :delete_all

  validates :unit_id, presence: true
  validates :icc_id, presence: true
  validates :author_id, presence: true
  validates :editor_id, numericality: { allow_nil: true }
  validates :master_id, numericality: { allow_nil: true }
  validates :parent_id, numericality: { allow_nil: true }
  validates :source_book_id, presence: true
  validates :use_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :bloom, inclusion: { in: (1..6) }
  validates :degree, inclusion: { in: (1..5) }
  validates :lang, inclusion: { in: [0, 1] }
  validates :image, length: { maximum: 1.megabytes, message: 'Maximum 1MB', if: :image? }
  validates :title, presence: true
  validates :explanation, length: { maximum: 400 }

  accepts_nested_attributes_for :question_choices,
    allow_destroy: true,
    reject_if: proc { |a| a[:content].blank? }

  before_save lambda {
    if title.presence
      title_ = title.gsub('&nbsp;', '')
      title_ = ActionController::Base.helpers.sanitize(title_, tags: %w[p u ul li])
      self.title = title_.squish
    end

    self.explanation = explanation.squish if explanation.presence
  }

  mount_uploader :image, QuestionImageUploader

  def build_choices(choice_count = 5)
    choice_count.times { question_choices.build }
  end

  def set_answer
    update(answer_id: question_choices.first.id)
  end

  def self.degrees
    (1..5)
  end

  def self.blooms
    (1..6)
  end
end
