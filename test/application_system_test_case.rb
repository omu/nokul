# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  parallelize(workers: 1)

  driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080], options: {
    desired_capabilities: {
      chromeOptions: {
        args: %w[headless disable-gpu disable-dev-shm-usage]
      }
    }
  }
  Capybara.server = :puma, { Silent: true }

  SUPPORTED_SCREEN_RESOLUTIONS = [
    [1920, 1080], # desktop
    [1366, 768], # ultrabook
    [768, 1024], # tablet
    [360, 640] # small mobile device
  ].freeze
end
