# Testing RackStep framework. In this file we will test all valid ways of
# declaring routes.

require 'test_helper'

class ValidRoutesTest < RackStepTest

  # Test if the main route is returning the expected message.
  def test_main_route
    # Requesting the root page of the application.
    request = @requester.get URI.escape('/')
    # The response should be OK (200)
    assert_equal 200, request.status
    # Content type should be HTML
    assert_equal 'text/plain', request.content_type
    # Checking if the response contains the expceted text
    assert_contains "Welcome to the RackStep Sample App", request.body
  end

  # Test if the json route is returning the expected content.
  def test_json_route
    # Requesting the myJsonService page of the application.
    request = @requester.get URI.escape('/myJsonService')
    # The response should be OK (200)
    assert_equal 200, request.status
    # Content type should be JSON
    assert_equal 'application/json', request.content_type
    # Checking if the response contains the expceted text
    expected_body = '{"name":"John Doe","age":"27","job":"Developer"}'
    assert_contains expected_body, request.body
  end

  # Test if the erbPage route is returning the expected content. We want to
  # test if render_template is working properly.
  def test_render_erb_route
    # Requesting the htmlPage page of the application.
    request = @requester.get URI.escape('/erbPage')
    # The response should be OK (200)
    assert_equal 200, request.status
    # Content type should be HTML
    assert_equal 'text/html', request.content_type
    # Checking if the response contains the expceted text
    expected_body = 'This is the content of the attribute.'
    assert_contains expected_body, request.body
  end

end
