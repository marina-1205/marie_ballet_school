require "test_helper"

class Admin::LessonClassesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_lesson_classes_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_lesson_classes_edit_url
    assert_response :success
  end
end
