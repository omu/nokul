# frozen_string_literal: true

namespace :yoksis do
  desc 'fetches all academic staff defined in YOKSIS'
  task :fetch_academic_staff do
    # we simply don't store YOKSISResponse of this action because there is no consistency between responses
    # of each page - no ordering, no timestamp etc.
    client = Services::Yoksis::V1::AkademikPersonel.new

    # this endpoint uses pagination in a weird way
    number_of_pages = client.number_of_pages

    # fetch academic staff from each page
    (1..number_of_pages).each do |page_number|
      response = client.list_academic_staff(page_number)

      response.each do |academic_staff|
        # business-logic goes here

        # id_number = academic_staff[:tc_kimlik_no]
        # first_name = academic_staff[:adi]
        # last_name = academic_staff[:soyadi]
        # title = academic_staff[:kadro_unvan]
        # unit_id = academic_staff[:birim_id]
      end
    end
  end
end
