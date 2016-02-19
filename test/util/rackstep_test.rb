# Abstract class with some helpers to test classes.

require 'base64'
require 'test_helper'
require 'minitest_contains_assertion'

class RackStepTest < MiniTest::Test

  # Including rack test methods to allow use of assert_*.
  include Rack::Test::Methods

  # Setting up a Mock to simulate the requests.
  def setup
    @requester = Rack::MockRequest.new(SampleApp)
  end

  # Helper to test basic http authentication.
  def encode_credentials(username, password)
    "Basic " + Base64.encode64("#{username}:#{password}")
  end

end
