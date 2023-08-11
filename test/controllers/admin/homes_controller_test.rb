require "test_helper"

class Admin::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_homes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_homes_destroy_url
    assert_response :success
  end

  test "should get home" do
    get admin_homes_home_url
    assert_response :success
  end
end
