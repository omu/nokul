# frozen_string_literal: true

namespace :fetch do
  desc 'Fetch all references'
  task references: :environment do
    progress_bar = ProgressBar.spawn 'YOKSIS - Referanslar', 15

    %w[
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
      UnitType
      UnitInstructionLanguage
      UnitInstructionType
      UnitStatus
      UniversityType
    ].each do |klass|
      Rake::Task['fetch:reference'].invoke(klass.tableize, klass)

      # https://stackoverflow.com/questions/4822020/why-does-a-rake-task-in-a-loop-execute-only-once
      Rake::Task['fetch:reference'].reenable

      progress_bar&.increment
    end
  end

  # You can also call a specific task with its name (ie: reference['unit_types']).
  # If you're using a Shell other than Bash (e.g.: ZSH), you must escape braces.
  desc 'Fetch only one reference'
  task :reference, %i[action klass] => [:environment] do |_, args|
    response = Xokul::Yoksis::References.send(args[:action])
    response&.each { |reference| args[:klass].constantize.create(reference) }
  end
end
