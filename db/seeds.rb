# frozen_string_literal: true

# authorization data
Rake::Task['patron:all'].invoke

module PgExec
  module_function

  def call(sql)
    db = PG.connect(**args)
    # https://www.endpoint.com/blog/2015/01/28/postgres-sessionreplication-role
    db.exec <<~SQL
      SET session_replication_role = replica;
      #{sql}
      SET session_replication_role = origin;
    SQL
  ensure
    db.close
  end

  def args
    config = ActiveRecord::Base.configurations[Rails.env]
    {
      host:     config['host'],
      dbname:   config['database'],
      user:     config['username'],
      password: config['password']
    }
  end
end

ENCRYTED_DATA_DIR   = 'db/encrypted_data'
COMPRESSED_FILE_EXT = '.sql.enc.gz'

def restore_seed_data(encrypted_data_name)
  path = Rails.root.join(ENCRYTED_DATA_DIR, "#{encrypted_data_name}#{COMPRESSED_FILE_EXT}")

  abort("File not found in: #{path}") unless path.exist?

  PgExec.call(
    Support::Sensitive.content_decrypt(ActiveSupport::Gzip.decompress(File.read(path)))
  )
rescue PG::Error => e
  abort("SQL error during exec: #{e.message}")
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
  restore_seed_data('static_data')

  if ENV['SAMPLE_DATA'].eql?('true')
    restore_seed_data('sample_data')

    Dir[Rails.root.join('db/beta_seed/*.rb')].sort.each do |seed|
      load seed
    end
  end
end
