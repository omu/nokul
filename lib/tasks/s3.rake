# frozen_string_literal: true

require 'aws-sdk-s3'
require 'singleton'

class S3
  include Singleton

  TOPLEVEL = Rails.application.root
  BUCKET   = 'static'

  def initialize(config = Nokul::Tenant.credentials.config[:s3])
    @client = Aws::S3::Client.new(config)
  end

  def pull(file, bucket: BUCKET)
    Dir.chdir(TOPLEVEL) do
      target = File.join(Dir.pwd, file)
      key = File.basename(target)
      FileUtils.mkdir_p File.dirname(target)
      client.get_object bucket: bucket, key: key, response_target: target
    end
  rescue Errno::EEXIST
    warn "#{file} already exist."
  end

  def push(file, bucket: BUCKET)
    Dir.chdir(TOPLEVEL) do
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
      warn "#{file} pushing..."
      S3.instance.push(file)
    end
  rescue StandardError => e
    warn "An error occured: #{e}"
  end
end
