# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080]
  Capybara.server = :puma, { Silent: true }

  SUPPORTED_SCREEN_RESOLUTIONS = [
    [1920, 1080], # desktop
    [1366, 768], # ultrabook
    [768, 1024], # tablet
    [360, 640] # small mobile device
  ].freeze
end
