require 'test_helper'

class OperationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operation = operations(:one)
  end

  test "should get index" do
    get operations_url
    assert_response :success
  end

  test "should get new" do
    get new_operation_url
    assert_response :success
  end

  test "should create operation" do
    assert_difference('Operation.count') do
      post operations_url, params: { operation: { account_id: @operation.account_id, amount: @operation.amount, comment: @operation.comment, name: @operation.name, operation_category_id: @operation.operation_category_id, operation_date: @operation.operation_date, original_name: @operation.original_name, value_date: @operation.value_date } }
    end

    assert_redirected_to operation_url(Operation.last)
  end

  test "should show operation" do
    get operation_url(@operation)
    assert_response :success
  end

  test "should get edit" do
    get edit_operation_url(@operation)
    assert_response :success
  end

  test "should update operation" do
    patch operation_url(@operation), params: { operation: { account_id: @operation.account_id, amount: @operation.amount, comment: @operation.comment, name: @operation.name, operation_category_id: @operation.operation_category_id, operation_date: @operation.operation_date, original_name: @operation.original_name, value_date: @operation.value_date } }
    assert_redirected_to operation_url(@operation)
  end

  test "should destroy operation" do
    assert_difference('Operation.count', -1) do
      delete operation_url(@operation)
    end

    assert_redirected_to operations_url
  end
end
