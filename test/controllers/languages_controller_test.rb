# frozen_string_literal: true

require 'test_helper'

class LangugesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:serhat)
    @language = languages(:turkce)
  end

  test 'should get index' do
    get languages_path
    assert_response :success
    assert_select '#add-button', translate('.index.new_language_link')
  end

  test 'should get show' do
    get language_path(@language)
    assert_response :success
  end

  test 'should get new' do
    get new_language_path
    assert_response :success
  end

  test 'should create language' do
    assert_difference('Language.count') do
      post languages_path params: {
        language: {
          name: 'Test language', iso: 'TLC', yoksis_code: 5
        }
      }
    end

    language = Language.last

    assert_equal 'Test Language', language.name
    assert_equal 'TLC', language.iso
    assert_equal 5, language.yoksis_code
    assert_redirected_to language_path(language)
    assert_equal translate('.create.success'), flash[:notice]
  end

  test 'should get edit' do
    get edit_language_path(@language)
    assert_response :success

    assert_select '.card-header strong', translate('.edit.form_title')
  end

  test 'should update language' do
    language = Language.last
    patch language_path(language), params: {
      language: {
        name: 'Test language Update', iso: 'TLU', yoksis_code: nil
      }
    }

    language.reload

    assert_equal 'Test Language Update', language.name
    assert_equal 'TLU', language.iso
    assert_nil language.yoksis_code
    assert_redirected_to language_path(language)
    assert_equal translate('.update.success'), flash[:notice]
  end

  test 'should destroy language' do
    assert_difference('Language.count', -1) do
      delete language_path(Language.last)
    end

    assert_redirected_to languages_path
    assert_equal translate('.destroy.success'), flash[:notice]
  end

  private

  def translate(key)
    t("languages#{key}")
  end
end
