# frozen_string_literal: true

Dir.glob(File.join(__dir__, 'tasks', '*.rake')).each { |rake| import rake }
