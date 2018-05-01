require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get playlist" do
    get searches_playlist_url
    assert_response :success
  end

  test "should get user" do
    get searches_user_url
    assert_response :success
  end

  test "should get playlist_genre" do
    get searches_playlist_genre_url
    assert_response :success
  end

  test "should get user_genre" do
    get searches_user_genre_url
    assert_response :success
  end

end
