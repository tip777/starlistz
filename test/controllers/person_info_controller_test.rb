require 'test_helper'

class PersonInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get person_info_index_url
    assert_response :success
  end

  test "should get show" do
    get person_info_show_url
    assert_response :success
  end

end
