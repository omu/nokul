# frozen_string_literal: true

namespace :developer do
  desc 'Checks if master_key is available'
  task :master_key do |task|
    puts "########### #{task.full_comment} ###########"
    if ENV['RAILS_MASTER_KEY'] || File.file?('config/master.key')
      puts "OK \u2713"
    else
      abort(
        "FAIL \u2717 "\
        'Can not reach master key! Either define a RAILS_MASTER_KEY in environment or store it in config/master.key'
      )
    end
  end

  desc 'Checks if fit-commit is installed'
  task :fit_commit do |task|
    puts "########### #{task.full_comment} ###########"
    Bundler.with_clean_env do
      unless command?('fit-commit')
        abort(
          "FAIL \u2717 "\
          'You must install fit-commit in development environment! '\
          "Run 'gem install fit-commit' first. "\
          "Then run 'fit-commit install' in the root directory of repository."
        )
      else
        puts "OK \u2713"
      end
    end
  end

  desc 'Runs all development machine tasks'
  task all: %w[master_key fit_commit]

  private

  def command?(command)
    system("which #{command} >/dev/null 2>&1")
  end
end
