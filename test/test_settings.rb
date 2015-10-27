# Testing RackStep framework. In this file we will test the 'global' setting.

require 'test_helper'

class ValidRoutesTest < MiniTest::Test

  # Including rack test methods to allow use of assert_*.
  include Rack::Test::Methods

  # Setting up a Mock to simulate the requests.
  def setup
    @requester = Rack::MockRequest.new(SampleApp)
  end

  # Test if the main route is returning the expected message.
  def test_settings
    # At the sample_app.rb we set a :config, lets check if it was injected into
    # the controller and if we can retrieve it back. For this, we created a
    # service, and here we will call that service.

    request = @requester.get URI.escape('/settingsTest')
    # The response should be OK (200)
    assert_equal 200, request.status
    # Content type should be JSON
    assert_equal 'application/json', request.content_type
    # Checking if the response contains the expceted text
    expected_body = 'This is just a settings test.'
    assert_contains expected_body, request.body
  end

end
