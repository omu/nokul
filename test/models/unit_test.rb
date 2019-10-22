# frozen_string_literal: true

require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :district
  belongs_to :unit_status
  belongs_to :unit_type, optional: true
  belongs_to :unit_instruction_type, optional: true
  belongs_to :unit_instruction_language, optional: true
  belongs_to :university_type, optional: true
  has_many :duties, dependent: :destroy
  has_many :employees, through: :duties
  has_many :students, dependent: :nullify
  has_many :users, through: :employees
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties
  has_many :agendas, dependent: :nullify
  has_many :meetings, dependent: :nullify, class_name: 'CommitteeMeeting'
  has_many :meeting_agendas, through: :meetings
  has_many :decisions, through: :meeting_agendas, class_name: 'CommitteeDecision'
  has_many :courses, dependent: :nullify
  has_many :course_groups, dependent: :nullify
  has_many :curriculum_programs, dependent: :destroy
  has_many :curriculums, through: :curriculum_programs
  has_many :managed_curriculums, dependent: :destroy, class_name: 'Curriculum'
  has_many :registration_documents, dependent: :destroy
  has_many :prospective_students, dependent: :destroy
  has_many :available_courses, dependent: :destroy
  has_many :unit_calendars, dependent: :destroy
  has_many :calendars, through: :unit_calendars

  # validations: presence
  validates_presence_of :name
  validates_presence_of :unit_status

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :yoksis_id

  # validations: length
  validates_length_of :abbreviation
  validates_length_of :code
  validates_length_of :name

  # callbacks
  test 'callbacks must titlecase the name for a unit' do
    unit = units(:omu).dup
    unit.update!(yoksis_id: 123_459, name: 'wonderunit department')
    assert_equal unit.name, 'Wonderunit Department'
  end

  # search
  test 'unit is a searchable model' do
    assert_not_empty Unit.search('Ondokuz')
    assert_includes(Unit.search('Ondokuz'), units(:omu))
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
