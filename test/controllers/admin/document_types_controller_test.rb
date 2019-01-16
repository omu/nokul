# frozen_string_literal: true

require 'test_helper'

module Admin
  class DocumentTypesControllerTest < ActionDispatch::IntegrationTest
    setup do
      sign_in users(:john)
      @document_type = document_types(:health_report)
      @form_params = %w[name active]
    end

    test 'should get index' do
      get admin_document_types_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate('.index.new_document_type_link')
    end

    test 'should get new' do
      get new_admin_document_type_path
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#document_type_#{param}"
        end
      end
    end

    test 'should create document' do
      assert_difference('DocumentType.count') do
        post admin_document_types_path, params: {
          document_type: { name: 'Sample Document' }
        }
      end

      assert_equal 'create', @controller.action_name

      document_type = DocumentType.last

      assert_equal 'Sample Document', document_type.name
      assert_redirected_to admin_document_types_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get edit_admin_document_type_path(@document_type)

      assert_equal 'edit', @controller.action_name

      assert_response :success
      assert_select '.simple_form' do
        @form_params.each do |param|
          assert_select "#document_type_#{param}"
        end
      end
    end

    test 'should update document' do
      document_type = DocumentType.last
      patch admin_document_type_path(document_type), params: {
        document_type: { name: 'Another Document' }
      }

      assert_equal 'update', @controller.action_name

      document_type.reload

      assert_equal 'Another Document', document_type.name
      assert_redirected_to admin_document_types_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy document' do
      assert_difference('DocumentType.count', -1) do
        delete admin_document_type_path(document_types(:document_to_delete))
      end

      assert_equal 'destroy', @controller.action_name

      assert_redirected_to admin_document_types_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def translate(key)
      t("admin.document_types#{key}")
    end
  end
end
