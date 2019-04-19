# frozen_string_literal: true

def load_seed_data
  Dir[Rails.root.join('db', 'beta_seed', '*.rb')].sort.each do |seed|
    load seed
  end
end

class RestoreEncryptedSql
  ENCRYTED_DATA_DIR = 'db/encrypted_data'
  COMPRESS_EXT      = '.tar.gz'

  def self.call(file_name)
    new(file_name).restore
  end

  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
    @dir       = Dir.tmpdir
  end

  def restore
    file = prepare_file_for_restored

    `#{db_connection + " -f #{file.path}"}`

    file.close
  end

  private

  attr_reader :dir

  def db_connection
    config     = ActiveRecord::Base.configurations[Rails.env]

    "PGPASSWORD=#{config['password']} psql \
    -h #{config['host']} \
    -U #{config['username']} \
    -d #{config['database']}"
  end

  def extract
    path = Rails.root.join(ENCRYTED_DATA_DIR, "#{file_name}#{COMPRESS_EXT}")

    `tar xvzf "#{path}" -C #{dir}`.strip
  end

  def prepare_file_for_restored
    extracted_file = extract.delete_suffix('.enc')

    tmp = Tempfile.new("#{file_name}-#{Time.now.to_i}.sql")

    # https://www.endpoint.com/blog/2015/01/28/postgres-sessionreplication-role
    tmp << <<-SQL
      SET session_replication_role = replica;
      #{Support::Sensitive.read("#{dir}/#{extracted_file}")}
      SET session_replication_role = origin;
    SQL
    tmp
  end
end

# Seed logic goes below

if ENV['SYNC'].eql?('true')
  Rake::Task['fetch:references'].invoke
  Rake::Task['import:all'].invoke

  if ENV['SAMPLE_DATA'].eql?('true')
    Rake::Task['fetch:academic_staff'].invoke
    Osym::ImportProspectiveStudentsJob.perform_later('db/encrypted_data/prospective_students.csv')
  end
else
  RestoreEncryptedSql.call('static_data')

  if ENV['SAMPLE_DATA'].eql?('true')
    RestoreEncryptedSql.call('sample_data')
    load_seed_data
  end
end
