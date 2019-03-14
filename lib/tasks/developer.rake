# frozen_string_literal: true

require 'open3'

NODEJS_TARGET_VERSION = 10
POSTGRESQL_TARGET_VERSION = 11

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
      if command?('fit-commit')
        puts "OK \u2713"
      else
        abort(
          "FAIL \u2717 "\
          'You must install fit-commit in development environment! '\
          "Run 'gem install fit-commit' first. "\
          "Then run 'fit-commit install' in the root directory of repository."
        )
      end
    end
  end

  desc 'Checks NodeJS and node version'
  task :nodejs do |task|
    puts "########### #{task.full_comment} ###########"

    begin
      stdout, _stderr, _status = Open3.capture3('node -v')
      version = stdout.split('.').first.tr('v', '').to_i
      if version < NODEJS_TARGET_VERSION
        abort(
          "FAIL \u2717 "\
          "You must install NodeJS! (>= v#{NODEJS_TARGET_VERSION}) "\
        )
      else
        puts "OK \u2713"
      end
    rescue Errno::ENOENT
      puts "You must install NodeJS! (>= v#{NODEJS_TARGET_VERSION})"
    end
  end

  desc 'Checks PostgreSQL version'
  task :postgresql do |task|
    puts "########### #{task.full_comment} ###########"

    begin
      stdout, _stderr, _status = Open3.capture3("psql --version | egrep -o '[0-9]{1,}\.[0-9]{1,}'")
      version = stdout.split('.').first.to_i
      if version < POSTGRESQL_TARGET_VERSION
        abort(
          "FAIL \u2717 "\
          "You must install PostgreSQL! (>= v#{POSTGRESQL_TARGET_VERSION}) "\
        )
      else
        puts "OK \u2713"
      end
    rescue Errno::ENOENT
      puts "You must install PostgreSQL! (>= v#{POSTGRESQL_TARGET_VERSION})"
    end
  end

  desc 'Runs all development machine tasks'
  task all: %w[master_key fit_commit nodejs postgresql]

  private

  def command?(command)
    system("which #{command} >/dev/null 2>&1")
  end
end
