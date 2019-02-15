# frozen_string_literal: true

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :district
  belongs_to :unit_status
  belongs_to :unit_type
  belongs_to :unit_instruction_type
  belongs_to :unit_instruction_language
  belongs_to :university_type
  has_many :duties
  has_many :employees
  has_many :students
  has_many :users
  has_many :positions
  has_many :administrative_functions
  has_many :agendas
  has_many :meetings
  has_many :meeting_agendas
  has_many :decisions
  has_many :courses
  has_many :course_groups
  has_many :curriculum_programs
  has_many :curriculums
  has_many :managed_curriculums
  has_many :registration_documents
  has_many :prospective_students
  has_many :available_courses
  has_many :unit_calendars
  has_many :calendars

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
    assert_includes Unit.active, units(:uzem)
    assert_not_includes Unit.active, units(:cbu)
  end

  test 'others scope returns other units' do
    assert_includes Unit.others, units(:omu)
    assert_not_includes Unit.others, units(:uzem)
  end

  test 'faculties scope returns faculties type units' do
    assert_includes Unit.faculties, units(:egitim_fakultesi)
    assert_not_includes Unit.faculties, units(:omu)
  end

  test 'departments scope returns departments type units' do
    assert_includes Unit.departments, units(:bilgisayar_muhendisligi)
    assert_not_includes Unit.departments, units(:omu)
  end

  test 'majors scope returns majors type units' do
    assert_includes Unit.majors, units(:bote_anabilim_dali)
    assert_not_includes Unit.majors, units(:egitim_fakultesi)
  end

  test 'undergraduate_programs scope returns undergraduate_program type units' do
    assert_includes Unit.undergraduate_programs, units(:fen_bilgisi_ogretmenligi_programi)
    assert_not_includes Unit.undergraduate_programs, units(:egitim_fakultesi)
  end

  test 'graduate_programs scope returns graduate_program type units' do
    assert_includes Unit.graduate_programs, units(:alman_dili_egitimi_dr)
    assert_not_includes Unit.graduate_programs, units(:egitim_fakultesi)
  end

  test 'institutes scope returns institutes type units' do
    assert_includes Unit.institutes, units(:egitim_bilimleri_enstitusu)
    assert_not_includes Unit.institutes, units(:egitim_fakultesi)
  end

  test 'research_centers scope returns research_centers type units' do
    assert_includes Unit.research_centers, units(:uzem)
    assert_not_includes Unit.research_centers, units(:egitim_fakultesi)
  end

  test 'committees scope returns committees type units' do
    assert_includes Unit.committees, units(:muhendislik_fakultesi_yonetim_kurulu)
    assert_not_includes Unit.committees, units(:omu)
  end

  test 'senates scope returns senato type units' do
    assert_includes Unit.senates, units(:senate)
    assert_not_includes Unit.senates, units(:omu)
  end

  test 'coursable scope returns coursable units' do
    assert_equal Unit.coursable.count,
                 Unit.departments.count +
                 Unit.faculties.count +
                 Unit.majors.count +
                 Unit.institutes.count +
                 Unit.others.count
    assert_not_includes Unit.coursable, units(:uzem)
  end

  test 'curriculumable scope returns curriculumable units' do
    assert_equal Unit.curriculumable.count, Unit.coursable.count
    assert_not_includes Unit.curriculumable, units(:uzem)
  end

  test 'eventable scope returns eventable units' do
    assert_equal Unit.eventable.count,
                 Unit.faculties.count +
                 Unit.institutes.count +
                 Unit.programs.count +
                 Unit.research_centers.count +
                 Unit.others.count
    assert_not_includes Unit.eventable, units(:muhendislik_fakultesi_yonetim_kurulu)
  end

  test 'academic scope returns academic units' do
    assert_equal Unit.academic.count,
                 Unit.faculties.count +
                 Unit.departments.count +
                 Unit.majors.count +
                 Unit.programs.count +
                 Unit.institutes.count
    assert_not_includes Unit.academic, units(:uzem)
  end

  # custom methods
  test 'subprograms method returns a unit subprograms' do
    assert_equal units(:omu).subprograms.count, units(:omu).descendants.programs.count
    assert_not_includes units(:omu).subprograms, units(:uzem)
  end

  test 'subtree_employees returns unit subtree employees' do
    employees = Employee.joins(:units, user: :identities).where(units: { id: units(:omu).subtree.active.ids })
    assert_equal employees.count, units(:omu).subtree_employees.count
  end
end
