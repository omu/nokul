# frozen_string_literal: true

class RakeJob < ApplicationJob
  Nokul::Application.load_tasks if Rake::Task.tasks.empty?

  def perform(args = {})
    name = args.fetch('name')

    Rake::Task[name].invoke(*args['params'])
    Rake::Task[name].reenable
    Rake::Task[name].prerequisite_tasks.each(&:reenable)
  end
end
