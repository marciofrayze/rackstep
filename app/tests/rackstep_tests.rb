# A simple unit test example.

# TODO: Move the requires, simplecov init, etc to another place to allow
# multiple test files to be executed.

# This environment variable may be used in your app to detect what is the
# current context of the application. In this exaple, this is irrevelant, but
# in a real application, you could use this to be able to detect inside your
# app that a unit test is being exacute, and use a differente database, for
# example.
ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'minitest/autorun'

# Using simplecov to generate a report.
require 'simplecov'
SimpleCov.start

require_relative "../main.rb"

# TODO: Move this to another place.
# Extending the Minitest framework a new assertion method (contains).
module Minitest::Assertions
  def assert_contains(exp_substr, obj, msg=nil)
    msg = message(msg) { "Expected #{mu_pp obj} to contain #{mu_pp exp_substr}" }
    assert_respond_to obj, :include?
    assert obj.include?(exp_substr), msg
  end
end

class ExampleTest < MiniTest::Test

  # Setting up
  # TODO: Move this to an abstract class?
  include Rack::Test::Methods
  def app
    AppRouter
  end
  def setup
    @requester = Rack::MockRequest.new(RackStep::Dispatcher)
  end

  # Test if the main route is returning the expected message.
  def test_main_route
    # Requesting the root page of the application.
    request = @requester.get URI.escape('/')
    # The response should be OK (200)
    assert_equal 200, request.status
    # Checking if the response contains the expceted text
    assert_contains "Welcome to RackStep", request.body
  end

  # Test if the invalid route is returning 404.
  def test_invalid_route
    # Requesting an invalid page.
    request = @requester.get URI.escape('/justAnInvalidPageRoute')
    # The response should be NOT FOUND (404)
    assert_equal 404, request.status
  end

end
