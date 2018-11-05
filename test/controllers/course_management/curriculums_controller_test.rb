# frozen_string_literal: true

require 'test_helper'

module CourseManagement
  class CurriculumsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @curriculum = curriculums(:one)
      @unit = units(:omu)
    end

    test 'should get index' do
      get index_path
      assert_response :success
      assert_select '#add-button', translate('.index.add_new_curriculum')
      assert_select '#collapseSearchLink', t('search')
    end

    test 'should get show' do
      get curriculum_path(@curriculum)
      assert_response :success
    end

    test 'should get new' do
      get new_curriculum_path
      assert_response :success
    end

    test 'should create curriculum' do
      assert_difference('Curriculum.count') do
        post index_path, params: {
          curriculum: {
            name: 'Test Create Curriculum', unit_id: @unit.id, status: :active
          }
        }
      end

      curriculum = Curriculum.last

      assert_equal 'Test Create Curriculum', curriculum.name
      assert curriculum.active?
      assert_redirected_to index_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_curriculum_path(@curriculum)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update curriculum' do
      curriculum = Curriculum.last
      patch curriculum_path(curriculum), params: {
        curriculum: {
          name: 'Test Update Curriculum', status: :passive
        }
      }

      curriculum.reload

      assert_equal 'Test Update Curriculum', curriculum.name
      assert curriculum.passive?
      assert_redirected_to index_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy curriculum' do
      assert_difference('Curriculum.count', -1) do
        delete curriculum_path(Curriculum.last)
      end

      assert_redirected_to index_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def index_path
      curriculums_path
    end

    def translate(key)
      t("course_management.curriculums#{key}")
    end
  end
end
