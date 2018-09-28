# frozen_string_literal: true

require 'test_helper'

class LoginPageInteractionTest < ActionDispatch::IntegrationTest
  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can see login elements with a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(resolution[0], resolution[1])
      visit('/')
      assert find_button(t('devise.common.login'), visible: true).visible?
      assert find_link(t('devise.sessions.new.did_you_forget'), visible: true).visible?
      assert find_link(t('devise.sessions.new.create_account'), visible: true).visible?
    end
  end
end
