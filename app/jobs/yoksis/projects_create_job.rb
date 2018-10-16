# frozen_string_literal: true

module Yoksis
  class ProjectsCreateJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.projects(id_number: user.id_number.to_i)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first
      response = [@response].flatten

      response.each do |study|
        user.projects.create(
          yoksis_id: study[:project_id],
          name: study[:name],
          subject: study[:subject],
          status: study[:status_id],
          start_date: study[:date_of_start],
          end_date: study[:date_of_end],
          budget: study[:budget],
          duty: study[:location_name],
          type: study[:type_name],
          currency: study[:currency_name],
          last_update: study[:date_of_update],
          activity: study[:active_or_passive_id],
          scope: study[:scope_id],
          title: study[:title_name],
          unit_id: study[:institution_id],
          incentive_point: study[:incentive_points]
        )
      end
    end
  end
end
