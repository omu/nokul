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
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate(".index.new_#{@singular_variable}_link")
    end

    test 'should get new' do
      get send("new_admin_#{@singular_variable}_path")
      assert_equal 'new', @controller.action_name
      assert_response :success
    end

    test 'should create instance' do
      assert_difference('@model_name.count') do
        post controller_index_path, params: {
          @singular_variable => @variables
        }
      end

      assert_equal 'create', @controller.action_name

      instance = @model_name.last

      @variables.each do |key, value|
        assert_equal value, instance.send(key)
      end
      assert_redirected_to controller_index_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get send("edit_admin_#{@singular_variable}_path", @instance)

      assert_equal 'edit', @controller.action_name
      assert_response :success

      @variables.each do |key, value|
        assert_select '.simple_form' do
          assert_select "##{@singular_variable}_#{key}"
        end
      end
    end

    test 'should update instance' do
      patch send("admin_#{@singular_variable}_path", @instance), params: {
        @singular_variable => @variables
      }

      assert_equal 'update', @controller.action_name

      @instance.reload

      @variables.each do |key, value|
        assert_equal value, @instance.send(key)
      end

      assert_redirected_to controller_index_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy instance' do
      assert_difference('@model_name.count', -1) do
        delete send("admin_#{@singular_variable}_path", @instance)
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to controller_index_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def controller_index_path
      send("admin_#{controller_name}_path")
    end

    def translate(key)
      t("admin.#{controller_name}#{key}")
    end
  end
  # rubocop:enable Metrics/BlockLength
end
