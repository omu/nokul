# frozen_string_literal: true

module Yoksis
  class ProspectiveStudentsSaveJob < ApplicationJob
    queue_as :high

    def perform(type, year)
      @type = type
      @year = year

      process
    end

    private

    def process(page: 0)
      response = Xokul::Yoksis::Prospectives.all(@type, @year, page: page)

      response[:data].each do |params|
        Actions::ProspectiveStudent::Upsert.call(params)
      rescue ActiveRecord::RecordInvalid => e
        next
      end

      current_page, total_pages = response.fetch(:meta, {}).values_at(:current_page, :total_pages)

      process(page: current_page + 1) if current_page < total_pages - 1
    end
  end
end
