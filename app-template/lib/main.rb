# A simple unit test example.

# This environment variable may be used in your app to detect what is the
# current context of the application. In this exaple, this is irrevelant, but
# in a real application, you could use this to be able to detect inside your
# app that a unit test is being exacute, and use a differente database, for
# example.
#ENV['RACK_ENV'] = 'test'

#require 'rackstep'
#require_relative '../../app'
#require 'rack/test'
#require 'minitest/autorun'
#require 'simplecov'

# TODO: Move this to another place.
# Extending the Minitest framework a new assertion method (contains).
module Minitest::Assertions
  def assert_contains(exp_substr, obj, msg=nil)
    msg = message(msg) { "Expected #{mu_pp obj} to contain #{mu_pp exp_substr}" }
    assert_respond_to obj, :include?
    assert obj.include?(exp_substr), msg
  end
end

# Using simplecov to generate a report.
#SimpleCov.start
