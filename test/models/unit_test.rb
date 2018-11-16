# frozen_string_literal: true

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # relations
  %i[
    district
    unit_status
    unit_type
    unit_instruction_type
    unit_instruction_language
    university_type
    duties
    employees
    students
    users
    positions
    administrative_functions
    agendas
    meetings
    meeting_agendas
    decisions
    courses
    registration_documents
    prospective_students
    calendar_units
    academic_calendars
  ].each do |property|
    test "a unit can communicate with #{property}" do
      assert units(:omu).send(property)
    end
  end

  # validations: presence
  %i[
    district
    name
    unit_status
  ].each do |property|
    test "presence validations for #{property} of a unit" do
      units(:omu).send("#{property}=", nil)
      assert_not units(:omu).valid?
      assert_not_empty units(:omu).errors[property]
    end
  end

  # validations: uniqueness
  %i[
    name
    yoksis_id
    detsis_id
  ].each do |property|
    test "uniqueness validations for #{property} of a unit" do
      fake = units(:omu).dup
      assert_not fake.valid?
    end
  end

  # callbacks
  test 'callbacks must titlecase the name for a unit' do
    unit = units(:omu).dup
    unit.update!(yoksis_id: 123_459, name: 'wonderunit department')
    assert_equal unit.name, 'Wonderunit Department'
  end

  # search
  test 'unit is a searchable model' do
    assert_not_empty Unit.search('Ondokuz')
    assert Unit.search('Ondokuz').include?(units(:omu))
    assert_not Unit.search('Ondokuz').include?(units(:uzem))
  end

  # scopes
  test 'active scope returns active units' do
    assert_includes Unit.active, units(:omu)
    assert_not_includes Unit.active, units(:cbu)
  end

  test 'committees scope returns committees type units' do
    assert_includes Unit.committees, units(:muhendislik_fakultesi_yonetim_kurulu)
    assert_not_includes Unit.committees, units(:omu)
  end

  test 'departments scope returns departments type units' do
    assert_includes Unit.departments, units(:bilgisayar_muhendisligi)
    assert_not_includes Unit.departments, units(:omu)
  end

  test 'faculties scope returns faculties type units' do
    assert_includes Unit.faculties, units(:egitim_fakultesi)
    assert_not_includes Unit.faculties, units(:omu)
  end

  test 'programs scope returns programs type units' do
    assert_includes Unit.programs, units(:fen_bilgisi_ogretmenligi_programi)
    assert_not_includes Unit.programs, units(:egitim_fakultesi)
  end

  test 'universities scope returns universities type units' do
    assert_includes Unit.universities, units(:omu)
    assert_not_includes Unit.universities, units(:egitim_fakultesi)
  end

  test 'majors scope returns majors type units' do
    assert_includes Unit.majors, units(:bote_anabilim_dali)
    assert_not_includes Unit.majors, units(:egitim_fakultesi)
  end

  test 'institutes scope returns institutes type units' do
    assert_includes Unit.institutes, units(:egitim_bilimleri_enstitusu)
    assert_not_includes Unit.institutes, units(:egitim_fakultesi)
  end

  test 'coursable scope returns coursable units' do
    assert_equal Unit.coursable.count,
                 Unit.departments.count +
                 Unit.faculties.count +
                 Unit.universities.count +
                 Unit.majors.count +
                 Unit.institutes.count +
                 Unit.rectorships.count
    assert_not_includes Unit.coursable, units(:uzem)
  end

  test 'curriculumable scope returns curriculumable units' do
    assert_equal Unit.curriculumable.count.to_i,
                 Unit.departments.count +
                 Unit.faculties.count +
                 Unit.universities.count +
                 Unit.majors.count +
                 Unit.institutes.count +
                 Unit.rectorships.count
    assert_not_includes Unit.curriculumable, units(:uzem)
  end

  test 'subprograms method returns a unit subprograms' do
    assert_equal units(:omu).subprograms.count, units(:omu).descendants.programs.count
    assert_not_includes units(:omu).subprograms, units(:uzem)
  end
end
