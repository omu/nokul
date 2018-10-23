# frozen_string_literal: true

require 'test_helper'

class ProfileSettingFlowTest < ActionDispatch::IntegrationTest
  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can profile setting with correct credentials with a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(resolution[0], resolution[1])
      login_as(users(:serhat), scope: :user, run_callbacks: false)
      visit('/profile')
      attach_file('user[avatar]', File.absolute_path('test/fixtures/files/valid_jpg_picture.jpg'))
      fill_in('user[phone_number]', with: '362 312 1919')
      fill_in('user[extension_number]', with: '1234')
      fill_in('user[website]', with: 'http://example.com')
      fill_in('user[twitter]', with: 'example')
      fill_in('user[linkedin]', with: 'example')
      fill_in('user[skype]', with: 'example')
      fill_in('user[orcid]', with: 'example')
      click_button(t('save'))
      assert_equal t('account.profile.update.success'), page.find('div', class: 'toast-message').text
    end
  end
end
