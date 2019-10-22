# frozen_string_literal: true

module Yoksis
  class ProjectsSaveJob < ApplicationJob
    queue_as :high

    # slow operation
    def perform(user)
      @response = Xokul::Yoksis::Resumes.projects(id_number: user.id_number)
    end

    # callbacks
    after_perform do |job|
      user = job.arguments.first

      [*@response].each do |project|
        user_project = user.projects.find_or_initialize_by(yoksis_id: project[:id])
        user_project.assign_attributes(
          yoksis_id: project[:id],
          status:    project[:status_id],
          duty:      project[:location_name],
          type:      project[:type_name],
          currency:  project[:currency_name],
          activity:  project[:activity_id],
          scope:     project[:scope_id],
          title:     project[:title_name],
          **project.slice(:name, :subject, :start_date, :end_date, :budget, :last_update, :unit_id, :incentive_point)
        )
        user_project.save
      end
    end
  end
end
