require 'test_helper'

class OperationCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operation_category = operation_categories(:one)
  end

  test "should get index" do
    get operation_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_operation_category_url
    assert_response :success
  end

  test "should create operation_category" do
    assert_difference('OperationCategory.count') do
      post operation_categories_url, params: { operation_category: { name: @operation_category.name, operation_category_id: @operation_category.operation_category_id } }
    end

    assert_redirected_to operation_category_url(OperationCategory.last)
  end

  test "should show operation_category" do
    get operation_category_url(@operation_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_operation_category_url(@operation_category)
    assert_response :success
  end

  test "should update operation_category" do
    patch operation_category_url(@operation_category), params: { operation_category: { name: @operation_category.name, operation_category_id: @operation_category.operation_category_id } }
    assert_redirected_to operation_category_url(@operation_category)
  end

  test "should destroy operation_category" do
    assert_difference('OperationCategory.count', -1) do
      delete operation_category_url(@operation_category)
    end

    assert_redirected_to operation_categories_url
  end
end
