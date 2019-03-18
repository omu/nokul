# frozen_string_literal: true

module YoksisResourceTest
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/BlockLength
  included do
    setup do
      sign_in users(:serhat)
      @singular_variable = controller_name.singularize
      @model_name = controller_name.classify.constantize
      @instance = @model_name.last
      @target_path = 'yoksis'
    end

    test 'should get index' do
      get controller_index_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate(".index.new_#{@singular_variable}_link")
    end

    test 'should get new' do
      get send("new_#{@target_path}_#{@singular_variable}_path")
      assert_equal 'new', @controller.action_name
      assert_response :success
    end

    test 'should create instance' do
      assert_difference('@model_name.count') do
        post controller_index_path, params: {
          @singular_variable => { name: 'Test Create', code: 999_998 }
        }
      end

      assert_equal 'create', @controller.action_name

      instance = @model_name.last

      assert_equal 'Test Create', instance.name
      assert_equal 999_998, instance.code
      assert_redirected_to controller_index_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get send("edit_#{@target_path}_#{@singular_variable}_path", @instance)

      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        assert_select "##{@singular_variable}_name"
        assert_select "##{@singular_variable}_code"
      end
    end

    test 'should update instance' do
      patch send("#{@target_path}_#{@singular_variable}_path", @instance), params: {
        @singular_variable => { name: 'Test Update', code: 999_999 }
      }

      assert_equal 'update', @controller.action_name

      @instance.reload

      assert_equal 'Test Update', @instance.name
      assert_equal 999_999, @instance.code
      assert_redirected_to controller_index_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy instance' do
      assert_difference('@model_name.count', -1) do
        delete send("#{@target_path}_#{@singular_variable}_path", @instance)
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to controller_index_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def controller_index_path
      send("#{@target_path}_#{controller_name}_path")
    end

    def translate(key)
      t("#{@target_path}.#{controller_name}#{key}")
    end
  end
  # rubocop:enable Metrics/BlockLength
end
