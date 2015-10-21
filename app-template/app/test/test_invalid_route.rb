# This test class was created just to show you that you may separate your tests
# in multiple files.

require 'test_helper'

class InvalidRoutesTest < MiniTest::Test

  # Including rack test methods to allow use of assert_*.
  include Rack::Test::Methods

  # Setting up a Mock to simulate the requests.
  def setup
    @requester = Rack::MockRequest.new(App)
  end

  # Test if the invalid route is returning 404.
  def test_invalid_route
    # Requesting an invalid page.
    request = @requester.get URI.escape('/justAnInvalidPageRoute')
    # The response should be NOT FOUND (404)
    assert_equal 404, request.status
  end

end
