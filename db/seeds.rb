# frozen_string_literal: true

def load_seed_data
  Dir[Rails.root.join('db', 'beta_seed', '*.rb')].sort.each do |seed|
    load seed
  end
end

def extract_file(file_name)
  extraction_path = Rails.root.join('db', 'encrypted_data', "#{file_name}.tar.gz").to_s
  `tar xvzf "#{extraction_path}" -C tmp/`
end

def decrypt_and_write_to_file(file_name)
  file_to_decrypt = "tmp/#{file_name}.sql.enc"
  file_to_write = "tmp/#{file_name}.sql"
  File.write(
    file_to_write,
    Support::Sensitive.read(file_to_decrypt)
  )
end

def restore_sql_dump(file_name)
  config = ActiveRecord::Base.configurations[Rails.env]
  dump_file = Rails.root.join('tmp', "#{file_name}.sql")

  connection = "PGPASSWORD=#{config['password']} psql \
               -h #{config['host']} \
               -d #{config['database']} \
               -U #{config['username']} "

  `#{connection + "-f #{dump_file}"}`
end

def restore_from_backup(file_name)
  extract_file(file_name)
  decrypt_and_write_to_file(file_name)
  restore_sql_dump(file_name)
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
  restore_from_backup('static_data')

  if ENV['SAMPLE_DATA'].eql?('true')
    restore_from_backup('sample_data') if ENV['SAMPLE_DATA'].eql?('true')
    load_seed_data
  end
end
