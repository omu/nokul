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

module Git
  module_function

  def toplevel
    build %w[rev-parse --show-toplevel]
  end

  class << self
    private

    def build(args)
      ['git', *args]
    end
  end
end

class S3
  include Singleton

  BUCKET = 'static'

  def initialize(config = Tenant.credentials.config[:s3])
    @client = Aws::S3::Client.new(config)
  end

  def pull(source, target, bucket: BUCKET)
    Dir.chdir(Shell.run_or_die(Git.toplevel).outline) do
      origdir = Dir.pwd
      dest = File.join(origdir, target, source)
      FileUtils.mkdir_p File.dirname(dest)
      client.get_object bucket: bucket, key: source, response_target: dest
    end
  rescue Errno::EEXIST
    warn "#{target} already exist."
  end

  def push(source, bucket: BUCKET)
    Dir.chdir(Shell.run_or_die(Git.toplevel).outline) do
      origdir = Dir.pwd
      dest = File.join(origdir, source)
      file_name = File.basename(source)
      client.put_object bucket: bucket, body: IO.read(dest), key: file_name
    end
  rescue Errno::ENOENT
    warn "#{source} does not exist."
  end

  protected

  attr_reader :client
end

OBJECTS = [
  { source: 'sample_data.sql.enc.gz', target: 'db/encrypted_data' },
  { source: 'static_data.sql.enc.gz', target: 'db/encrypted_data' }
].freeze

namespace :s3 do
  desc 'Pull S3 objects from remote'
  task :pull do
    OBJECTS.each do |object|
      puts "#{object[:source]} pulling..."
      S3.instance.pull(*object.values)
    end
  rescue StandardError => e
    warn "An error occured for #{object}: #{e}"
  end

  desc 'Push S3 objects to remote'
  task :push do
    OBJECTS.each do |object|
      puts "#{object[:source]} pushing..."
      src = File.join(object[:target], object[:source])
      S3.instance.push(src)
    end
  rescue StandardError => e
    warn "An error occured for #{object}: #{e}"
  end
end
