# frozen_string_literal: true

require 'test_helper'

module Actions
  module ProspectiveStudent
    class UpsertTest < ActiveSupport::TestCase
      DATA = {
        id_number:                       11_223_344_556,
        first_name:                      'Foo',
        last_name:                       'Bar',
        fathers_name:                    'Father',
        mothers_name:                    'Mother',
        gender:                          'female',
        date_of_birth:                   '1999-01-01',
        nationality:                     'turkish',
        place_of_birth:                  'Atakum',
        registration_city:               'Samsun',
        registration_district:           'Bafra',
        high_school_code:                552_188,
        high_school_type:                11_033,
        high_school_branch:              9008,
        high_school_graduation_year:     2015,
        state_of_education:              6,
        placement_type:                  'general',
        placement_score:                 450.000,
        placement_score_type:            'TYT',
        placement_rank:                  40_000,
        address:                         'Address',
        home_phone:                      903_623_121_919,
        mobile_phone:                    9_069_944_433_322,
        email:                           'foo@example.com',
        top_student:                     false,
        university_code:                 1082,
        university_name:                 'Ondokuz Mayıs Üniversitesi',
        faculty_name:                    'Mühendislik Fakültesi',
        program_code:                    108_210_665,
        program_name:                    'Bilgisayar Mühendisliği Pr.',
        preference_order:                1,
        quota:                           'Genel',
        exam_score:                      345.4,
        meb_status:                      true,
        meb_status_date:                 '2019-09-19T15:56:43.000+00:00',
        military_status:                 true,
        military_status_date:            '2019-09-19T19:28:11.000+00:00',
        obs_status:                      false,
        obs_status_date:                 '2019-09-23T09:52:22.000+00:00',
        current_program:                 0,
        online_registration_term_code:   12,
        online_registration_term_name:   '2019-YKS Ek Yerleştirme',
        online_registration_term_type:   'YKS_EK',
        online_registration_permit_code: 3,
        online_registration_permit_date: nil
      }.freeze

      test 'can create a prospective student' do
        assert_difference '::ProspectiveStudent.count', 1 do
          Actions::ProspectiveStudent::Upsert.call(DATA)
        end
      end
    end
  end
end
