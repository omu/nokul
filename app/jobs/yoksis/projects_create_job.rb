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

      response.each do |project|
        user.projects.create(
          yoksis_id: project[:id],
          status: project[:status_id],
          duty: project[:location_name],
          type: project[:type_name],
          currency: project[:currency_name],
          activity: project[:activity_id],
          scope: project[:scope_id],
          title: project[:title_name],
          **project.slice(:name, :subject, :start_date, :end_date, :budget, :last_update, :unit_id, :incentive_point)
        )
      end
    end
  end
end
