require "test_helper"

class NavigationTest < ActionDispatch::IntegrationTest
  test "loads page from test slider in dummy app" do
    get "/dummy_slider/welcome"

    assert_response :success
    assert_select "h1", "Welcome to the Test Slider"
  end
end
