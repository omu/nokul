# frozen_string_literal: true

require 'mkmf'

module Environment
  MASTER_KEY_PATH  = Pathname.new(Rails.root.join('config/master.key'))
  MIN_NODE_VERSION = '10'
  MIN_PSQL_VERSION = '11'

  module_function

  def rails_master_key?
    MASTER_KEY_PATH.exist? || ENV['RAILS_MASTER_KEY']
  end

  def tenant_master_key?
    MASTER_KEY_PATH.exist? || ENV['TENANT_MASTER_KEY']
  end

  def fit_commit?
    !find_executable('fit-commit').nil?
  end

  def node?
    !find_executable('node').nil?
  end

  def psql?
    !find_executable('psql').nil?
  end

  def node_version_ok?
    version = `node -v`.chomp.delete_prefix 'v'
    Gem::Version.new(MIN_NODE_VERSION) < Gem::Version.new(version)
  end

  def psql_version_ok?
    version = `psql --version`.chomp[/\d+\.\d+/]
    Gem::Version.new(MIN_PSQL_VERSION) < Gem::Version.new(version)
  end
end

namespace :prerequisities do
  desc 'Check Rails master key on the system'
  task rails_master_key: :environment do
    abort 'Rails master key not configured!' unless Environment.rails_master_key?
  end

  desc 'Check Tenant master key on the system'
  task tenant_master_key: :environment do
    abort 'Tenant master key not configured!' unless Environment.tenant_master_key?
  end

  desc 'Check fit-commit on the system'
  task 'fit-commit': :environment do
    abort 'fit-commit not found!' unless Environment.fit_commit?
  end

  desc 'Check NodeJS on the system'
  task node: :environment do
    abort 'node not found!' unless Environment.node?
    abort 'node version is wrong!' unless Environment.node_version_ok?
  end

  desc 'Check PostgreSQL on the system'
  task psql: :environment do
    abort 'psql not found!' unless Environment.psql?
    abort 'psql version is wrong!' unless Environment.psql_version_ok?
  end

  desc 'Run all the prerequisite checks'
  task all: %w[rails_master_key tenant_master_key fit-commit node psql]
end
