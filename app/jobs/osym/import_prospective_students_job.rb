# frozen_string_literal: true

module Osym
  class ImportProspectiveStudentsJob < ApplicationJob
    queue_as :high

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/BlockLength
    def perform
      content = FileEncryptor.decrypt_lines('db/encrypted_data/prospective_students.csv.enc')

      progress_bar = ProgressBar.create(
        title: 'Prospective Students',
        total: content.count,
        format: '%t %B %c/%C %a'
      )

      content.each do |prospective_student|
        id_number, first_name, last_name, fathers_name, mothers_name, d, m, y, gender, turkish, kktc, foreign,
        place_of_birth, registration_city, registration_district, high_school_code, high_school_type,
        high_school_branch, state_of_education, high_school_graduation_year, placement_type, exam_score, language,
        address, district, city, home_phone, mobile_phone, email, student_disability_type, top_student, placement_score,
        placement_rank, _university_code, _university_name, _faculty_name, department_code, _department_name,
        preference_order, placement_score_type, additional_score, _quota, meb_status, _meb_status_description,
        meb_status_date, military_status, _military_status_description, military_status_date, obs_status,
        obs_status_date, obs_registered_program = prospective_student.split('|').map(&:strip)

        # nationality
        nationality = find_nationality(turkish, kktc, foreign)
        placement_type = find_placement_type(placement_type)
        language = find_language(language)
        student_disability_type = find_student_disability_type(student_disability_type)
        additional_score = find_additional_score(additional_score)
        obs_registered_program = find_obs_registered_program(obs_registered_program)
        high_school_type = find_high_school_type(high_school_type)

        ProspectiveStudent.create(
          id_number: id_number,
          first_name: first_name,
          last_name: last_name,
          fathers_name: fathers_name,
          mothers_name: mothers_name,
          date_of_birth: Date.parse("#{y}-#{m}-#{d}"),
          gender: gender.eql?('E') ? 'male' : 'female',
          nationality: nationality,
          place_of_birth: place_of_birth,
          registration_city: registration_city,
          registration_district: registration_district,
          high_school_code: high_school_code,
          high_school_type: high_school_type,
          high_school_branch: high_school_branch,
          state_of_education: state_of_education,
          high_school_graduation_year: high_school_graduation_year,
          placement_type: placement_type,
          exam_score: exam_score,
          language: language,
          address: address + ' ' + district + '/' + city,
          home_phone: home_phone,
          mobile_phone: mobile_phone,
          email: email,
          student_disability_type: student_disability_type,
          top_student: top_student.eql?('1') ? true : false,
          placement_score: placement_score,
          placement_rank: placement_rank,
          unit: Unit.find_by(osym_id: department_code),
          preference_order: preference_order,
          placement_score_type: placement_score_type,
          additional_score: additional_score,
          meb_status: meb_status.eql?('1') ? true : false,
          meb_status_date: parse_date(meb_status_date),
          military_status: military_status.eql?('101') ? true : false,
          military_status_date: parse_date(military_status_date),
          obs_status: obs_status.eql?('0') ? true : false,
          obs_status_date: parse_date(obs_status_date),
          obs_registered_program: obs_registered_program,
          student_entrance_type: StudentEntranceType.find_by(code: 1) # TODO: will be dynamic in the future
        )
        progress_bar.increment
      end
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/BlockLength

    private

    def find_nationality(turkish, kktc, foreign)
      'turkish' if turkish.eql?('1')
      'kktc' if kktc.eql?('1')
      'foreign' if foreign.eql?('1')
    end

    def find_placement_type(str)
      'general' if str.eql?('Genel')
      'additional_score' if str.eql?('Ek Puanli')
    end

    def find_language(language)
      Language.find_by(name: language.capitalize_all) unless language.eql?('null')
    end

    def find_obs_registered_program(program)
      return if program.eql?('0') || program.eql?('null')

      response = Yoksis::V4::UniversiteBirimler.new.program_name(program)
      "#{response[:universite][:ad]} / #{response[:birim][:ad]}"
    end

    def find_student_disability_type(student_disability_type)
      StudentDisabilityType.find_by(code: student_disability_type) unless student_disability_type.eql?('null')
    end

    def find_additional_score(str)
      'handicapped' if str.eql?('Özürlü Ek Puan')
    end

    def find_high_school_type(high_school_type)
      HighSchoolType.find_by(code: high_school_type) unless high_school_type.eql?('null')
    end

    def parse_date(date)
      Date.parse(date) unless date.eql?('null')
    end
  end
end
