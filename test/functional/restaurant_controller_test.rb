require File.dirname(__FILE__) + '/../test_helper'
require 'restaurant_controller'

# Re-raise errors caught by the controller.
class RestaurantController; def rescue_action(e) raise e end; end

class RestaurantControllerTest < Test::Unit::TestCase
  def setup
    @controller = RestaurantController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end