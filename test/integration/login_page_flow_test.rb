# frozen_string_literal: true

require 'test_helper'

class LoginPageFlowTest < ActionDispatch::IntegrationTest
  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can login with correct credentials with a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(resolution[0], resolution[1])
      visit('/')
      fill_in('user[id_number]', with: users(:serhat).id_number)
      fill_in('user[password]', with: '123456')
      check(t('devise.sessions.new.remember_login'))
      click_button(t('devise.common.login'))
      assert_equal t('devise.sessions.signed_in'), page.find('div', class: 'toast-message').text
    end
  end
end
