# frozen_string_literal: true

require 'test_helper'

class AcademicTermTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  has_many :calendars, dependent: :nullify
  has_many :prospective_students, dependent: :nullify
  has_many :registration_documents, dependent: :nullify
  has_many :semester_registrations, dependent: :nullify
  has_many :tuitions, dependent: :nullify

  # validations: presence
  validates_presence_of :active
  validates_presence_of :end_of_term
  validates_presence_of :start_of_term
  validates_presence_of :term
  validates_presence_of :year

  # validations: uniqueness
  validates_uniqueness_of :year

  # validations: length
  validates_length_of :year

  # enums
  enum term: { fall: 0, spring: 1, summer: 2 }

  # validations: AcademicTermValidator
  test 'one of the academic terms must be active' do
    active_term = AcademicTerm.active.last
    active_term.update(active: false)
    assert_not active_term.valid?
    assert_not_empty active_term.errors[:active]
  end

  # scopes
  test 'active scope returns active academic terms' do
    assert_includes AcademicTerm.active, academic_terms(:active_term)
    assert_not_includes AcademicTerm.active, academic_terms(:spring_2017_2018)
  end

  # callbacks
  after_save :deactivate_academic_terms

  test 'callback ensures that only one academic term must be active' do
    active_term = AcademicTerm.active.last
    passive_term = academic_terms(:fall_2017_2018)

    passive_term.update!(active: true)
    active_term.reload

    assert passive_term.active?
    assert_not active_term.active?
  end
end
