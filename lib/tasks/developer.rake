# frozen_string_literal: true

require 'open3'

NODEJS_TARGET_VERSION = 10
POSTGRESQL_TARGET_VERSION = 11

namespace :developer do
  desc 'Checks developer machine prerequisities!'
  task prerequisities: :environment do |task|
    puts "########### #{task.full_comment} ###########"
    check_secret_key('RAILS_MASTER_KEY', Rails.root.join('config', 'master.key'))
    check_secret_key('TENANT_MASTER_KEY', Tenant.root.join('config', 'master.key'))
    check_command('fit-commit')
    check_nodejs_version
    check_postgresql_version
  end
end

private

def check_secret_key(env_var, path)
  if ENV[env_var] || File.file?(path)
    puts "OK \u2713 #{env_var} exists!"
  else
    abort(
      "FAIL \u2717 Can not reach #{env_var} key!"
    )
  end
end

def check_command(command)
  Bundler.with_clean_env do
    if command?(command)
      puts "OK \u2713 #{command} is reachable!"
    else
      abort("FAIL \u2717 #{command} can not be reachable. Install required packages first.")
    end
  end
end

def command?(command)
  system("which #{command} >/dev/null 2>&1")
end

def check_nodejs_version
  stdout, _stderr, _status = Open3.capture3('node -v')
  version = stdout.split('.').first.tr('v', '').to_i

  if version < NODEJS_TARGET_VERSION
    abort("FAIL \u2717 You must install NodeJS! (>= v#{NODEJS_TARGET_VERSION})")
  else
    puts "OK \u2713 NodeJS instance is up to date!"
  end
rescue Errno::ENOENT
  puts "You must install NodeJS! (>= v#{NODEJS_TARGET_VERSION})"
end

def check_postgresql_version
  stdout, _stderr, _status = Open3.capture3("psql --version | egrep -o '[0-9]{1,}\.[0-9]{1,}'")
  version = stdout.split('.').first.to_i
  if version < POSTGRESQL_TARGET_VERSION
    abort("FAIL \u2717 You must install PostgreSQL! (>= v#{POSTGRESQL_TARGET_VERSION})")
  else
    puts "OK \u2713 PostgreSQL istance is up to date!"
  end
rescue Errno::ENOENT
  puts "You must install PostgreSQL! (>= v#{POSTGRESQL_TARGET_VERSION})"
end
