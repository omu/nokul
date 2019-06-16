# frozen_string_literal: true

module Academics
  YAML_PATH = Rails.root.join('db', 'encrypted_data', 'academics.yml')

  module_function

  def total_pages
    Xokul::Yoksis::Staff.total_pages
  end

  def pages
    total_pages.times do |number|
      page = Xokul::Yoksis::Staff.pages(page: number + 1)
      yield number + 1, page if block_given?
    end
  end

  def load_from_file
    raw = Support::Sensitive.read(YAML_PATH)
    YAML.safe_load(raw)
  end

  def update_from_file!
    load_from_file.each do |id_number, email|
      user = User.find_by(id_number: id_number)
      user&.update!(email: email)
    end
  end
end

namespace :fetch do
  desc 'Fetch all academic staff defined in YOKSIS'
  task academic_staff: :environment do
    ActionMailer::Base.perform_deliveries = false

    Academics.pages do |page_number, page|
      progress_bar = ProgressBar.spawn("Academic Staff - Page #{page_number}", page.size)

      page.each do |staff|
        password = SecureRandom.uuid

        user = User.new(
          id_number:             staff[:id_number],
          email:                 "#{staff[:id_number]}@omu.edu.tr",
          password:              password,
          password_confirmation: password
        )

        next unless user.save

        progress_bar&.increment

        title = Title.find_by(name: staff[:title].capitalize_turkish)
        unit = Unit.find_by(yoksis_id: staff[:unit_id])

        employee = Employee.create(title: title, user: user)
        employee.duties.create(temporary: false, start_date: Time.zone.today, unit: unit)
      end
    end

    Academics.update_from_file!

    ActionMailer::Base.perform_deliveries = true
  end
end
