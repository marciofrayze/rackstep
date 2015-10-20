# Unit test helper. This file will be loaded into the path when running
# 'rake test' and your unit tests should require this file to load some
# basic dependancies and to load SimpleCov.

# This environment variable may be used in your app to detect what is the
# current context of the application. In this exaple, this is irrevelant, but
# in a real application, you could use this to be able to detect inside your
# app that a unit test is being exacute, and use a differente database, for
# example.
ENV['RACK_ENV'] = 'test'

# Starting SimpleCov to create a report about unit test coverage. The result
# will be available at the coverage folder after you execute the tests by
# running 'rake test'.
# Please note that you must run SimpleCov.start before requiring your
# application files and minitest/autorun, otherwise your test result will be
# compromised.
require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end

# Loading rack test dependancies
require 'minitest/autorun'
require 'rack/test'

# Loading RackStep files
require 'rackstep'

# Loading App
require_relative '../../app'

# TODO: Move this to another place?
# Extending the Minitest framework a new assertion method (contains).
module Minitest::Assertions
  def assert_contains(exp_substr, obj, msg=nil)
    msg = message(msg) { "Expected #{mu_pp obj} to contain #{mu_pp exp_substr}" }
    assert_respond_to obj, :include?
    assert obj.include?(exp_substr), msg
  end
end
