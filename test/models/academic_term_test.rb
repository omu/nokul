# frozen_string_literal: true

require 'test_helper'
require_relative './concerns/enum_for_term_test'

class AcademicTermTest < ActiveSupport::TestCase
  include EnumForTermTest

  setup do
    @academic_term = academic_terms(:fall_2017_2018)
  end

  # relations
  %i[
    calendars
    registration_documents
  ].each do |property|
    test "a academic term can communicate with #{property}" do
      assert @academic_term.send(property)
    end
  end

  # validations: presence
  %i[
    year
    term
    start_of_term
    end_of_term
  ].each do |property|
    test "presence validations for #{property} of a academic term" do
      @academic_term.send("#{property}=", nil)
      assert_not @academic_term.valid?
      assert_not_empty @academic_term.errors[property]
    end
  end

  # validations: uniqueness
  test 'academic term should be unique based on year' do
    fake_term = @academic_term.dup
    assert_not fake_term.valid?
    assert_not_empty fake_term.errors[:year]
  end

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
