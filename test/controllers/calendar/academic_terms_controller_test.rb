# frozen_string_literal: true

require 'test_helper'

module Calendar
  class AcademicTermsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @academic_term = academic_terms(:fall_2017_2018)
    end

    test 'should get index' do
      get academic_terms_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_academic_term_link')
    end

    test 'should get new' do
      get new_academic_term_path
      assert_response :success
    end

    test 'should create academic term' do
      assert_difference('AcademicTerm.count') do
        post academic_terms_path, params: {
          academic_term: { year: '2019 - 2020', term: :spring,
                           start_of_term: '2019-01-15 08:00:00'.in_time_zone,
                           end_of_term: '2019-06-18 17:00:00'.in_time_zone }
        }
      end

      academic_term = AcademicTerm.last

      assert_equal '2019 - 2020', academic_term.year
      assert_equal 'spring', academic_term.term
      assert_equal '2019-01-15 08:00:00'.in_time_zone, academic_term.start_of_term
      assert_equal '2019-06-18 17:00:00'.in_time_zone, academic_term.end_of_term
      assert_equal false, academic_term.active
      assert_redirected_to academic_terms_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_academic_term_path(@academic_term)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update academic term' do
      academic_term = AcademicTerm.last
      patch academic_term_path(academic_term),
            params: {
              academic_term: { year: '2020 - 2021', term: :summer }
            }

      academic_term.reload

      assert_equal '2020 - 2021', academic_term.year
      assert_equal 'summer', academic_term.term
      assert_redirected_to academic_terms_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy academic term' do
      assert_difference('AcademicTerm.count', -1) do
        delete academic_term_path(AcademicTerm.last)
      end

      assert_redirected_to academic_terms_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("calendar.academic_terms#{key}")
    end
  end
end
