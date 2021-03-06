# frozen_string_literal: true

require 'csv'

CourseType.create(
  [
    { name: 'Alan Eğitimi', code: 'AE', min_credit: 1 },
    { name: 'Genel Kültür', code: 'GK', min_credit: 1 },
    { name: 'Meslek Bilgisi', code: 'MB', min_credit: 1 },
    { name: 'Staj', code: 'STG', min_credit: 0 }
  ]
)

CourseGroupType.create(name: 'Seçmeli Ders')

class DepartmentCourse
  include Nokul::Support::Structure.of %i[
    code
    course_name
    course_type_code
    credit
    department_yoksis_id
    ects
    group_name
    laboratory
    lang
    practice
    program_type
    program_yoksis_id
    semester
    theoric
    type
    year
  ]

  def unit
    @unit ||= Unit.find_by(yoksis_id: department_yoksis_id)
  end

  def language
    Language.find_by(name: lang)
  end

  def course_type
    CourseType.find_by(code: course_type_code)
  end

  def create
    Course.create(
      code: code, course_type_id: course_type.id,
      credit: credit, laboratory: laboratory,
      language_id: language.id, name: course_name,
      practice: practice, program_type: program_type,
      status: :active, theoric: theoric, unit_id: unit.id
    )
  end

  def compulsory?
    type == 'compulsory'
  end

  def elective?
    type == 'elective'
  end

  def course
    Course.find_by(code: code, unit_id: unit.id)
  end

  def curriculum
    @curriculum ||= Curriculum.find_by(unit_id: unit.id, status: :active)
  end

  def curriculum_semester
    curriculum.semesters.find_by(sequence: semester.to_i)
  end

  def course_group
    CourseGroup.find_by(name: group_name, unit_id: unit.id)
  end

  def find_or_create_curriculum_course_group
    CurriculumCourseGroup.find_or_create_by(
      curriculum_semester_id: curriculum_semester.id,
      course_group_id:        course_group.id,
      ects:                   course_group.total_ects_condition
    )
  end

  def create_curriculum_course
    curriculum_course = CurriculumCourse.new(
      curriculum_semester_id: curriculum_semester.id,
      course_id:              course.id,
      ects:                   ects
    )
    curriculum_course.curriculum_course_group = find_or_create_curriculum_course_group if elective?
    curriculum_course.save
  end
end

class DepartmentCourses < Nokul::Support::Collection
  def unit
    @unit ||= first.unit
  end

  def programs
    @programs ||= Unit.where(yoksis_id: first.program_yoksis_id.split(','))
  end

  def elective_courses
    @elective_courses = select(&:elective?).group_by(&:group_name)
  end

  def create_course_groups
    elective_courses.each do |key, department_courses|
      courses = department_courses.map(&:course)
      CourseGroup.create(
        name:                 key,
        total_ects_condition: department_courses.sum { |c| c.ects.to_i },
        unit_id:              unit.id,
        course_group_type_id: CourseGroupType.find_by(name: 'Seçmeli Ders').id,
        course_ids:           courses.map(&:id)
      )
    end
  end

  def create_curriculum
    curriculum = Curriculum.new(
      name:        "#{unit.name} Müfredatı",
      status:      'active',
      unit_id:     unit.id,
      program_ids: programs.pluck(:id)
    )
    curriculum.build_semesters
    curriculum.save
  end
end

def build_curriculum(source)
  courses = DepartmentCourses.create(
    CSV.foreach(source, headers: true, col_sep: '|', header_converters: :symbol, skip_blanks: true).map(&:to_h)
  )

  courses.each(&:create)
  courses.create_course_groups
  courses.create_curriculum
  courses.each(&:create_curriculum_course)
end

%w[courses_for_bote courses_for_tarim_ekonomisi].each do |file_name|
  build_curriculum(Rails.root.join('db', 'seed_data', "#{file_name}.csv"))
end
