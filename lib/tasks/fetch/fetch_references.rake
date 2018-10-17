# frozen_string_literal: true

namespace :fetch do
  # call a specific task by mentioning it's name, ie:
  # rake yoksis:reference['unit_instruction_languages']
  # if you are using zsh you must escape braces though, ie:
  # rake yoksis:reference\['unit_instruction_languages'\]

  desc 'fetches all references'
  task :references do
    progress_bar = ProgressBar.spawn('YOKSIS Referanslar', 15)

    %w[
      unit_types
      unit_instruction_languages
      unit_instruction_types
      unit_statuses
      university_types
      administrative_functions
      student_disability_types
      student_drop_out_types
      student_education_levels
      student_entrance_point_types
      student_entrance_types
      student_grades
      student_grading_systems
      student_punishment_types
      student_studentship_statuses
    ].each do |action|
      Rake::Task['fetch:reference'].invoke(action)
      # https://stackoverflow.com/questions/4822020/why-does-a-rake-task-in-a-loop-execute-only-once
      Rake::Task['fetch:reference'].reenable
      progress_bar.increment
    end
  end

  desc 'fetches an individual reference'
  task :reference, [:action] => [:environment] do |_, args|
    action = args[:action]
    response = Xokul::Yoksis::References.send(action)
    create_records(response, action.classify.constantize)

    # TODO: checking old YoksisResponse records and creating new ones
    # client = Yoksis::V1::Referanslar.new
    # api_name = client.class.to_s.split('::')[1]
    # endpoint = client.class.to_s.split('::')[3]
    # response = client.send(args[:soap_method])]

    # calculate sha1 of the response
    # sha1 = Digest::SHA1.hexdigest(response.to_s)

    # find if any records exists for this api_action
    # current_response = YoksisResponse.find_by(name: api_name, endpoint: endpoint, action: action)

    # create records and log the action if no records found
    # create_records(response, action.classify.constantize) unless current_response

    # update the timestamp if we already have the same response
    # if current_response && current_response.sha1.eql?(sha1)
    #   current_response.update(syncronized_at: Time.current)
    # else
    #   create_yoksis_response(api_name, endpoint, api_action, sha1)
    #   # TODO: Notify operators to check changes at YOKSIS API. Never trust data coming from YOKSIS, check manually.
    # end
  end

  # def create_yoksis_response(api_name, endpoint, api_action, sha1)
  #   YoksisResponse.create(name: api_name, endpoint: endpoint, action: api_action, sha1: sha1)
  # end

  def create_records(response, klass)
    response.each { |reference| klass.create(reference) }
  end
end
