require 'test_helper'

class ContestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get leaderboard" do
    get :leaderboard
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get signup" do
    get :signup
    assert_response :success
  end

end
