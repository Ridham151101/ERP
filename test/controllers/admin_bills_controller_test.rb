require "test_helper"

class AdminBillsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_bills_index_url
    assert_response :success
  end

  test "should get update" do
    get admin_bills_update_url
    assert_response :success
  end
end
