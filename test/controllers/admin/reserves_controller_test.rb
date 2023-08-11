require "test_helper"

class Admin::ReservesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_reserves_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_reserves_show_url
    assert_response :success
  end
end
