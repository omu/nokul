# frozen_string_literal: true

namespace :fetch do
  # call a specific task by mentioning it's name, ie:
  # rake yoksis:reference['unit_instruction_languages']
  # if you are using zsh you must escape braces though, ie:
  # rake yoksis:reference\['unit_instruction_languages'\]

  desc 'fetches all references'
  task :references do
    progress_bar = ProgressBar.spawn('YOKSIS Referanslar', 15)

    {
      unit_types: 'UnitType',
      unit_instruction_languages: 'UnitInstructionLanguage',
      unit_instruction_types: 'UnitInstructionType',
      unit_statuses: 'UnitStatus',
      university_types: 'UniversityType',
      administrative_functions: 'AdministrativeFunction',
      student_disability_types: 'StudentDisabilityType',
      student_dropout_types: 'StudentDropOutType',
      student_education_levels: 'StudentEducationLevel',
      student_entrance_point_types: 'StudentEntrancePointType',
      student_entrance_types: 'StudentEntranceType',
      student_grades: 'StudentGrade',
      student_grading_systems: 'StudentGradingSystem',
      student_punishment_types: 'StudentPunishmentType',
      studentship_statuses: 'StudentStudentshipStatus'
    }.each do |action, klass|
      Rake::Task['fetch:reference'].invoke(action, klass)
      # https://stackoverflow.com/questions/4822020/why-does-a-rake-task-in-a-loop-execute-only-once
      Rake::Task['fetch:reference'].reenable
      progress_bar&.increment
    end
  end

  desc 'fetches an individual reference'
  task :reference, %i[action klass] => [:environment] do |_, args|
    response = Xokul::Yoksis::References.send(args[:action])
    create_records(response, args[:klass].constantize)
  end

  def create_records(response, klass)
    response.each { |reference| klass.create(reference) }
  end
end
