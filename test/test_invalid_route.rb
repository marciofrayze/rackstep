# This test class was created just to show you that you may separate your tests
# in multiple files.

require 'test_helper'

class InvalidRoutesTest < RackStepTest

  # Test if the invalid route is returning 404.
  def test_invalid_route
    # Requesting an invalid page.
    request = @requester.get '/justAnInvalidServiceRoute'
    # The response should be NOT FOUND (404)
    assert_equal 404, request.status
  end

  def test_controller_without_process_request
    # Requesting the route that didnt implemented the process_request method.
    request = @requester.get '/processRequestorNotImplemented'
    # The response should be status 500
    assert_equal 500, request.status
  end

end
