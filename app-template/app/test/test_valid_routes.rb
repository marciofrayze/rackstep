# This is just an unit test example class.

require 'test_helper'

class ValidRoutesTest < MiniTest::Test

  # Including rack test methods to allow use of assert_*.
  include Rack::Test::Methods

  # Setting up a Mock to simulate the requests.
  def setup
    @requester = Rack::MockRequest.new(App)
  end

  # Test if the main route is returning the expected message.
  def test_main_route
    # Requesting the root page of the application.
    request = @requester.get URI.escape('/')
    # The response should be OK (200)
    assert_equal 200, request.status
    # Content type should be HTML
    assert_equal 'text/html', request.content_type
    # Checking if the response contains the expceted text
    assert_contains "Welcome to RackStep", request.body
  end

  # Test if the json route is returning the expected content.
  def test_json_route
    # Requesting the root page of the application.
    request = @requester.get URI.escape('/json')
    # The response should be OK (200)
    assert_equal 200, request.status
    # Content type should be JSON
    assert_equal 'application/json', request.content_type
    # Checking if the response contains the expceted text
    expected_body = '{"name":"John Doe","age":"27","job":"Developer"}'
    assert_contains expected_body, request.body
  end

end
