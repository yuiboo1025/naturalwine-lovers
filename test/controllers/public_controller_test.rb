require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get searches" do
    get public_searches_url
    assert_response :success
  end
end
