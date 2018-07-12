# frozen_string_literal: true

module ReferenceResourceTest
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/BlockLength
  included do
    setup do
      sign_in users(:serhat)
      @singular_variable = controller_name.singularize
      @model_name = controller_name.classify.constantize
      @instance = @model_name.last
    end

    test 'should get index' do
      get controller_index_path
      assert_response :success
      assert_select '#add-button', translate(".index.new_#{@singular_variable}_link")
    end

    test 'should get new' do
      get send("new_#{@singular_variable}_path")
      assert_response :success
    end

    test 'should create instance' do
      assert_difference('@model_name.count') do
        post controller_index_path, params: {
          @singular_variable => { name: 'Test Create', code: 999_998 }
        }
      end

      instance = @model_name.last

      assert_equal 'Test Create', instance.name
      assert_equal 999_998, instance.code
      assert_redirected_to controller_index_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get send("edit_#{@singular_variable}_path", @instance)
      assert_response :success
      assert_select '.card-header strong', translate('.edit.form_title')
    end

    test 'should update instance' do
      patch send("#{@singular_variable}_path", @instance), params: {
        @singular_variable => { name: 'Test Update', code: 999_999 }
      }

      @instance.reload

      assert_equal 'Test Update', @instance.name
      assert_equal 999_999, @instance.code
      assert_redirected_to controller_index_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy instance' do
      assert_difference('@model_name.count', -1) do
        delete send("#{@singular_variable}_path", @instance)
      end

      assert_redirected_to controller_index_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def controller_index_path
      send("#{controller_name}_path")
    end

    def translate(key)
      t("references.#{controller_name}#{key}")
    end
  end
  # rubocop:enable Metrics/BlockLength
end
