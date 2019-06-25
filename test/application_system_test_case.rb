# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  SUPPORTED_SCREEN_RESOLUTIONS = [
    [1920, 1080], # desktop
    [1366, 768],  # ultrabook
    [768, 1024],  # tablet
    [360, 640]    # small mobile device
  ].freeze

  Capybara.server = :puma, { Silent: true }

  Capybara.register_driver 'chrome_headless' do |driver|
    options = Selenium::WebDriver::Chrome::Options.new

    if ActiveRecord::Type::Boolean.new.cast(ENV['NO_HEADLESS'])
      options.add_argument '--start-maximized'
      options.add_argument '--auto-open-devtools-for-tabs'
    else
      options.add_argument '--headless'
    end

    options.add_argument '--no-sandbox'
    options.add_argument '--disable-gpu'
    options.add_argument '--disable-dev-shm-usage'
    options.add_argument '--disable-popup-blocking'

    Capybara::Selenium::Driver.new(driver, browser: :chrome, options: options)
  end

  driven_by 'chrome_headless'
end
