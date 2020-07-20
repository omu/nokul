# frozen_string_literal: true

namespace :db do
  namespace :dump do
    desc 'dump sample_data tables as SQL INSERTs'
    task sample_data: :environment do
      sh 'pg_dump \
        -h localhost \
        -p 5432 \
        -U nokul -W \
        -t "users" \
        -t "employees" \
        -t "duties" \
        -t "positions" \
        -t "addresses" \
        -t "identities" \
        -t "prospective_students" \
        --data-only \
        --column-inserts \
        nokul_development > tmp/sample_data.sql
      '

      Nokul::Support::Sensitive.read_write 'tmp/sample_data.sql'

      sh 'gzip -c tmp/sample_data.sql.enc > db/encrypted_data/sample_data.sql.enc.gz'
      sh 'rm tmp/sample_data.*'
    end

    desc 'Dump static_data tables as SQL INSERTs'
    task static_data: :environment do
      sh 'pg_dump \
        -h localhost \
        -p 5432 \
        -U nokul -W \
        -t "unit_types" \
        -t "unit_instruction_languages" \
        -t "unit_instruction_types" \
        -t "unit_statuses" \
        -t "university_types" \
        -t "administrative_functions" \
        -t "student_disability_types" \
        -t "student_drop_out_types" \
        -t "student_education_levels" \
        -t "student_entrance_point_types" \
        -t "student_entrance_types" \
        -t "student_grades" \
        -t "student_grading_systems" \
        -t "student_punishment_types" \
        -t "student_studentship_statuses" \
        -t "countries" \
        -t "cities" \
        -t "districts" \
        -t "languages" \
        -t "titles" \
        -t "high_school_types" \
        -t "units" \
        --data-only \
        --column-inserts \
        nokul_development > tmp/static_data.sql
      '

      Nokul::Support::Sensitive.read_write 'tmp/static_data.sql'

      sh 'gzip -c tmp/static_data.sql.enc > db/encrypted_data/static_data.sql.enc.gz'
      sh 'rm tmp/static_data.*'
    end
  end
end
