# frozen_string_literal: true

require 'test_helper'

module Admin
  class TitlesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @title = titles(:professor)
      @form_params = %w[name code branch]
    end

    test 'should get index' do
      get admin_titles_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.index.new_title_link')
    end

    test 'should get new' do
      get new_admin_title_path
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#title_#{param}"
        end
      end
    end

    test 'should create title' do
      assert_difference('Title.count') do
        post admin_titles_path, params: {
          title: {
            name: 'Test title', code: '1234', branch: 'GİH'
          }
        }
      end

      assert_equal 'create', @controller.action_name

      title = Title.last

      assert_equal 'Test title', title.name
      assert_equal '1234', title.code
      assert_equal 'GİH', title.branch
      assert_redirected_to admin_titles_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_admin_title_path(@title)

      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#title_#{param}"
        end
      end
    end

    test 'should update title' do
      title = Title.last
      patch admin_title_path(title), params: {
        title: {
          name: 'Test title update', code: '4321', branch: 'FOO'
        }
      }

      assert_equal 'update', @controller.action_name

      title.reload

      assert_equal 'Test title update', title.name
      assert_equal '4321', title.code
      assert_equal 'FOO', title.branch
      assert_redirected_to admin_titles_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy title' do
      assert_difference('Title.count', -1) do
        delete admin_title_path(titles(:title_to_delete))
      end

      assert_equal 'destroy', @controller.action_name

      assert_redirected_to admin_titles_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("admin.titles#{key}")
    end
  end
end
