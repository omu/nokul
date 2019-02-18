# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class LoginPageFlowTest < ApplicationSystemTestCase
  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can login with correct credentials with a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(resolution[0], resolution[1])
      visit('/')
      assert find_button(t('account.sessions.new.login'), visible: true).visible?
      assert find_link(t('account.sessions.new.did_you_forget'), visible: true).visible?
      assert find_link(t('account.sessions.new.create_account'), visible: true).visible?
      fill_in('user[id_number]', with: users(:serhat).id_number)
      fill_in('user[password]', with: '123456')
      check(t('account.sessions.new.remember_login'))
      click_button(t('account.sessions.new.login'))
      assert_equal t('devise.sessions.signed_in'), page.find('div', class: 'toast-message').text
    end
  end
end
