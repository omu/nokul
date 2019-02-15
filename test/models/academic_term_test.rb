# frozen_string_literal: true

require 'test_helper'
require_relative './concerns/enum_for_term_test'

class AcademicTermTest < ActiveSupport::TestCase
  include EnumForTermTest
  include AssociationTestModule
  include ValidationTestModule

  # relations
  has_many :calendars
  has_many :registration_documents

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

  # validations: AcademicTermValidator
  test 'one of the academic terms must be active' do
    active_term = AcademicTerm.active.last
    active_term.update(active: false)
    assert_not active_term.valid?
    assert_not_empty active_term.errors[:active]
  end

  # enums
  test_term_enum(AcademicTerm)

  # scopes
  test 'active scope returns active academic terms' do
    assert_includes AcademicTerm.active, academic_terms(:fall_2018_2019)
    assert_not_includes AcademicTerm.active, academic_terms(:spring_2017_2018)
  end

  # callbacks
  test 'callbacks only one academic term must be active' do
    active_term = AcademicTerm.active.last
    passive_term = academic_terms(:fall_2017_2018)

    passive_term.update!(active: true)
    active_term.reload

    assert passive_term.active?
    assert_not active_term.active?
  end
end
