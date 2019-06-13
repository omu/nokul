# frozen_string_literal: true

require 'mkmf'

module Environment
  MASTER_KEY_PATH  = Pathname.new(Rails.root.join 'config', 'master.key')
  MIN_NODE_VERSION = '10'
  MIN_PSQL_VERSION = '11'

  module_function

  def rails_master_key?
    MASTER_KEY_PATH.exist? || ENV['RAILS_MASTER_KEYS']
  end

  def tenant_master_key?
    MASTER_KEY_PATH.exist? || ENV['TENANT_MASTER_KEY']
  end

  def fit_commit?
    !!find_executable('fit-commit')
  end

  def node?
    !!find_executable('node')
  end

  def psql?
    !!find_executable('psql')
  end

  def check_node_version
    version = `node -v`.chomp.tr 'v', ''
    Gem::Version.new(MIN_NODE_VERSION) < Gem::Version.new(version)
  end

  def check_psql_version
    version = `psql --version`.chomp[/[\d]+.[\d]+/]
    Gem::Version.new(MIN_PSQL_VERSION) < Gem::Version.new(version)
  end
end

namespace :prerequisities do
  desc 'Check Rails master key on the system'
  task :rails_master_key do
    abort 'Rails master key not configured!' unless Environment.rails_master_key?
  end

  desc 'Check Tenant master key on the system'
  task :tenant_master_key do
    abort 'Tenant master key not configured!' unless Environment.tenant_master_key?
  end

  desc 'Check fit-commit on the system'
  task 'fit-commit' do
    abort 'fit-commit not found!' unless Environment.fit_commit?
  end
  
  desc 'Check NodeJS on the system'
  task :node do
    abort 'node not found!' unless Environment.node?
    abort 'node version is wrong!' unless Environment.check_node_version
  end
  
  desc 'Check PostgreSQL on the system'
  task :psql do
    abort 'psql not found!' unless Environment.psql?
    abort 'psql version is wrong!' unless Environment.check_psql_version
  end
  
  desc 'Run all the prerequisite checks'
  task all: %w[rails_master_key tenant_master_key fit-commit node psql]
end