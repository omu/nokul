# frozen_string_literal: true

# Adds draw method into Rails routing
# It allows us to keep routing splitted into files

# https://gitlab.com/gitlab-org/gitlab-ce/blob/master/config/initializers/routing_draw.rb

# rubocop:disable Style/ClassAndModuleChildren
class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end
# rubocop:enable Style/ClassAndModuleChildren
