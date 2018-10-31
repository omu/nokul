# frozen_string_literal: true

namespace :fetch do
  # call a specific task by mentioning it's name, ie:
  # rake yoksis:reference['unit_instruction_languages']
  # if you are using zsh you must escape braces though, ie:
  # rake yoksis:reference\['unit_instruction_languages'\]

  desc 'fetches all references'
  task :references do
    progress_bar = ProgressBar.spawn('YOKSIS Referanslar', 15)

    %w[
      UnitType
      UnitInstructionLanguage
      UnitInstructionType
      UnitStatus
      UniversityType
      AdministrativeFunction
      StudentDisabilityType
      StudentDropOutType
      StudentEducationLevel
      StudentEntrancePointType
      StudentEntranceType
      StudentGrade
      StudentGradingSystem
      StudentPunishmentType
      StudentStudentshipStatus
    ].each do |klass|
      Rake::Task['fetch:reference'].invoke(klass.tableize, klass)
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
