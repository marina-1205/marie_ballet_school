require "test_helper"

class Public::ReservesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_reserves_new_url
    assert_response :success
  end

  test "should get complete" do
    get public_reserves_complete_url
    assert_response :success
  end
end
