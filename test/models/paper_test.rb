# frozen_string_literal: true

require 'test_helper'

class PaperTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :user
  belongs_to :country, optional: true

  # enums
  enum activity: { deleted: 0, active: 1 }
  enum presentation_type: { verbal: 33, guest_speaker: 39, poster: 38 }
  enum publication_status: { unpublished: 0, published: 1, accepted: 2 }
  enum scope: { national: 0, international: 1 }
  enum type: { full_text: 36, summary: 37 }
  enum type_of_release: { printed: 1, electronic: 2, printed_and_electronic: 3 }

  # validations: presence
  validates_presence_of :activity
  validates_presence_of :scope
  validates_presence_of :yoksis_id

  # validations: length
  validates_length_of :access_link, maximum: 2000
  validates_length_of :authors
  validates_length_of :city
  validates_length_of :discipline
  validates_length_of :doi
  validates_length_of :issn
  validates_length_of :issue
  validates_length_of :keywords, maximum: 4000
  validates_length_of :language_of_publication
  validates_length_of :print_isbn
  validates_length_of :special_issue
  validates_length_of :sponsored_by

  # validations: numericality
  validates_numericality_of :author_id
  validates_numericality_of :number_of_authors
  validates_numericality_of :incentive_point
  validates_numericality_of :first_page
  validates_numericality_of :last_page
  validates_numericality_of :volume
  validates_numericality_of :yoksis_id
  validates_numerical_range :author_id, greater_than_or_equal_to: 0
  validates_numerical_range :number_of_authors, greater_than: 0
  validates_numerical_range :incentive_point, greater_than_or_equal_to: 0
  validates_numerical_range :first_page, greater_than: 0, less_than_or_equal_to: 15_000
  validates_numerical_range :last_page, greater_than: 0, less_than_or_equal_to: 15_000
  validates_numerical_range :volume, greater_than_or_equal_to: 0
  validates_numerical_range :yoksis_id, greater_than_or_equal_to: 0
end
