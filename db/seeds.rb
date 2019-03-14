# frozen_string_literal: true

config = ActiveRecord::Base.configurations[Rails.env]

if ENV['SYNC'].eql?('true')
  Rake::Task['fetch:references'].invoke
  Rake::Task['import:all'].invoke
else
  connection = "PGPASSWORD=#{config['password']} psql \
               -h #{config['host']} \
               -d #{config['database']} \
               -U #{config['username']} "

  `tar xvzf #{Rails.root.join('db', 'encrypted_data', 'static_data.tar.gz').to_s} -C tmp/`
  File.write('tmp/static_data.sql', Support::Sensitive.read('tmp/static_data.sql.enc'))
  `#{connection + "-f #{Rails.root.join('tmp', 'static_data.sql')}"}`
end

if ENV['SAMPLE_DATA'].eql?('true')
  if ENV['SYNC'].eql?('true')
    Rake::Task['fetch:academic_staff'].invoke
    Osym::ImportProspectiveStudentsJob.perform_later('db/encrypted_data/prospective_students.csv')
  else
    `tar xvzf #{Rails.root.join('db', 'encrypted_data', 'sample_data.tar.gz').to_s} -C tmp/`
    File.write('tmp/sample_data.sql', Support::Sensitive.read('tmp/sample_data.sql.enc'))

    `#{connection + "-f #{Rails.root.join('tmp', 'sample_data.sql')}"}`

    Dir[Rails.root.join('db', 'beta_seed', '*.rb')].sort.each do |seed|
      load seed
    end
  end
end
