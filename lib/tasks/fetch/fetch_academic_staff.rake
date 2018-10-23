# frozen_string_literal: true

namespace :fetch do
  desc 'fetches all academic staff defined in YOKSIS'
  task academic_staff: :environment do
    # we simply don't store YOKSISResponse of this action because there is no consistency between responses
    # of each page - no ordering, no timestamp etc.
    client = Xokul::Yoksis::Staff

    # this endpoint uses pagination in a weird way
    number_of_pages = client.total_pages[:total_pages]

    # id_number:email pairs for academics
    mail_list = FileEncryptor.decrypt_lines('db/encrypted_data/academics.csv.enc').map { |line| line.split('|') }

    # fetch academic staff from each page
    (1..number_of_pages).each do |page_number|
      response = client.pages(page: page_number)
      progress_bar = ProgressBar.spawn("Academic Staff - Page #{page_number}", response.size)

      response.each do |academic_staff|
        password = SecureRandom.uuid
        id_number = academic_staff[:id_number]

        user = User.new(
          id_number: id_number,
          email: "#{id_number}@omu.edu.tr",
          password: password,
          password_confirmation: password
        )

        next unless user.save

        progress_bar&.increment

        title = Title.find_by(name: academic_staff[:title].capitalize_all)
        unit = Unit.find_by(yoksis_id: academic_staff[:unit_id])

        employee = Employee.create(title: title, user: user)
        employee.duties.create(temporary: false, start_date: Time.zone.today, unit: unit)
      end
    end

    mail_list.each do |record|
      user = User.find_by(id_number: record.first)
      user&.update!(email: record.last)
    end
  end
end
