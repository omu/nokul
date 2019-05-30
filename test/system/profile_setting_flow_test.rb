# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class ProfileSettingFlowTest < ApplicationSystemTestCase
  setup do
    @user = users(:serhat)
    login_as(@user, scope: :user, run_callbacks: false)
  end

  SUPPORTED_SCREEN_RESOLUTIONS.each do |resolution|
    test "can profile setting with correct credentials with a #{resolution} screen" do
      page.driver.browser.manage.window.resize_to(*resolution)
      visit(profile_path)
      attach_file('user[avatar]', File.absolute_path('test/fixtures/files/valid_jpg_picture.jpg'))
      {
        fixed_phone: '362 312 1919',
        extension_number: '1234',
        website: 'http://example.com',
        twitter: 'twitter',
        linkedin: 'linkedin',
        skype: 'skype',
        orcid: 'orcid'
      }.each do |key, value|
        fill_in("user[#{key}]", with: value)
      end
      click_button(t('save'))
      assert_equal t('account.profile_settings.update.success'), page.find('div', class: 'toast-message').text
    end
  end
end
