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
      @create_params = { name: 'Test Create', code: 999_998 }
      @update_params = { name: 'Test Update', code: 999_999 }
    end

    test 'should get index' do
      get controller_index_path
      assert_equal 'index', @controller.action_name
      assert_response :success
      assert_select '#add-button', translate(".index.new_#{@singular_variable}_link")
    end

    test 'should get new' do
      get public_send("new_#{@target_path}_#{@singular_variable}_path")
      assert_equal 'new', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @create_params.with_indifferent_access.each do |param|
          assert_select "##{@singular_variable}_#{param[0]}"
        end
      end
    end

    test 'should create instance' do
      assert_difference('@model_name.count') do
        post controller_index_path, params: {
          @singular_variable => @create_params
        }
      end

      assert_equal 'create', @controller.action_name

      instance = @model_name.last

      @create_params.with_indifferent_access.each do |param|
        assert_equal param[1], instance.public_send(param[0])
      end

      assert_redirected_to controller_index_path
      assert_equal translate('.create.success'), flash[:notice]
    end

    test 'should get edit' do
      get public_send("edit_#{@target_path}_#{@singular_variable}_path", @instance)

      assert_equal 'edit', @controller.action_name
      assert_response :success
      assert_select '.simple_form' do
        @create_params.with_indifferent_access.each do |param|
          assert_select "##{@singular_variable}_#{param[0]}"
        end
      end
    end

    test 'should update instance' do
      patch public_send("#{@target_path}_#{@singular_variable}_path", @instance), params: {
        @singular_variable => @update_params
      }

      assert_equal 'update', @controller.action_name

      @instance.reload

      @update_params.with_indifferent_access.each do |param|
        assert_equal param[1], @instance.public_send(param[0].to_s)
      end

      assert_redirected_to controller_index_path
      assert_equal translate('.update.success'), flash[:notice]
    end

    test 'should destroy instance' do
      variable_to_delete = ActiveRecord::FixtureSet.identify("#{@singular_variable}_to_delete")

      assert_difference('@model_name.count', -1) do
        delete public_send("#{@target_path}_#{@singular_variable}_path", variable_to_delete)
      end

      assert_equal 'destroy', @controller.action_name
      assert_redirected_to controller_index_path
      assert_equal translate('.destroy.success'), flash[:notice]
    end

    private

    def controller_index_path
      public_send("#{@target_path}_#{controller_name}_path")
    end

    def translate(key)
      t("#{@target_path}.#{controller_name}#{key}")
    end
  end
  # rubocop:enable Metrics/BlockLength
end
