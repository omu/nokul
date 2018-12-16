# frozen_string_literal: true

require 'test_helper'

module References
  class TermsControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:serhat)
      @term = terms(:fall)
    end

    test 'should get index' do
      get terms_path
      assert_response :success
      assert_select '#add-button', translate('.index.new_term_link')
    end

    test 'should get new' do
      get new_term_path
      assert_response :success
    end

    test 'should create term' do
      assert_difference('Term.count') do
        post terms_path params: {
          term: { name: 'Test term', identifier: 'test-term' }
        }
      end

      term = Term.last

      assert_equal 'Test Term', term.name
      assert_equal 'test-term', term.identifier
      assert_redirected_to terms_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_term_path(@term)
      assert_response :success

      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update term' do
      term = Term.last
      patch term_path(term), params: {
        term: { name: 'Test term update', identifier: 'test-term-update' }
      }

      term.reload

      assert_equal 'Test Term Update', term.name
      assert_equal 'test-term-update', term.identifier
      assert_redirected_to terms_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy term' do
      assert_difference('Term.count', -1) do
        delete term_path(Term.last)
      end

      assert_redirected_to terms_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("references.terms#{key}")
    end
  end
end
