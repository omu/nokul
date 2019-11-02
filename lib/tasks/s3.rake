# frozen_string_literal: true

require 'aws-sdk-s3'
require 'fileutils'
require 'open3'
require 'singleton'

# Adapted from https://github.com/omu/zoo/blob/master/git-import/git-import
module Shell
  Result = Struct.new :args, :out, :err, :exit_code do
    def outline
      out.first
    end

    # :reek:NilCheck
    def ok?
      exit_code&.zero?
    end

    def notok?
      !ok?
    end

    def command
      args.join ' '
    end
  end

  # Adapted to popen3 from github.com/mina-deploy/mina
  class Runner
    def initialize
      @coathooks = 0
    end

    def run(*args)
      return dummy_result if args.empty?

      out, err, status =
        Open3.popen3(*args) do |_, stdout, stderr, wait_thread|
          block(stdout, stderr, wait_thread)
        end
      Result.new args, out, err, status.exitstatus
    end

    private

    attr_reader :coathooks

    def block(stdout, stderr, wait_thread)
      # Handle `^C`
      trap('INT') { handle_sigint(wait_thread.pid) }

      out = stdout.readlines.map(&:chomp)
      err = stderr.readlines.map(&:chomp)

      [out, err, wait_thread.value]
    end

    def handle_sigint(pid)
      message, signal = message_and_signal
      warn "\n" + message
      ::Process.kill signal, pid
      @coathooks += 1
    rescue Errno::ESRCH
      warn 'No process to kill.'
    end

    def message_and_signal
      if coathooks > 1
        ['SIGINT received again. Force quitting...', 'KILL']
      else
        ['SIGINT received.', 'TERM']
      end
    end
  end

  module_function

  def run(args, msg = nil)
    warn msg if msg
    Runner.new.run(*args)
  end

  def run_or_die(args, msg = nil)
    result = run(args, msg)
    result.ok? || abort("Command failed with exit code #{result.exit_code}: #{result.command}")
    result
  end
end

class S3
  include Singleton

  TOPLEVEL = %w[git rev-parse --show-toplevel].freeze
  BUCKET   = 'static'

  def initialize(config = Tenant.credentials.config[:s3])
    @client = Aws::S3::Client.new(config)
  end

  def pull(file, bucket: BUCKET)
    Dir.chdir(Shell.run_or_die(TOPLEVEL).outline) do
      target = File.join(Dir.pwd, file)
      key = File.basename(target)
      FileUtils.mkdir_p File.dirname(target)
      client.get_object bucket: bucket, key: key, response_target: target
    end
  rescue Errno::EEXIST
    warn "#{file} already exist."
  end

  def push(file, bucket: BUCKET)
    Dir.chdir(Shell.run_or_die(TOPLEVEL).outline) do
      body = IO.read(File.join(Dir.pwd, file))
      key = File.basename(file)
      client.put_object bucket: bucket, body: body, key: key
    end
  rescue Errno::ENOENT
    warn "#{file} does not exist."
  end

  protected

  attr_reader :client
end

namespace :s3 do
  FILES = %w[
    db/encrypted_data/sample_data.sql.enc.gz
    db/encrypted_data/static_data.sql.enc.gz
    lib/templates/ldap/openldap-2.4-bcyrpt-module.tar.gz
  ].freeze

  desc 'Pull S3 objects from remote'
  task pull: :environment do
    FILES.each do |file|
      warn "#{file} pulling..."
      S3.instance.pull(file)
    end
  rescue StandardError => e
    warn "An error occured: #{e}"
  end

  desc 'Push S3 objects to remote'
  task push: :environment do
    FILES.each do |file|
      puts "#{file} pushing..."
      S3.instance.push(file)
    end
  rescue StandardError => e
    warn "An error occured: #{e}"
  end
end
