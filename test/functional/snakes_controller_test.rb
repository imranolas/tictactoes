require 'test_helper'

class SnakesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get scores" do
    get :scores
    assert_response :success
  end

end
