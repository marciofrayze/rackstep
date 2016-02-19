# Unit test helper. This file will be loaded into the path when running
# 'rake test' and your unit tests should require this file to load some
# basic dependancies and to load SimpleCov.

# Requiring and starting statistics for codeclimate.com.
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

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

# Loading the sample App
require_relative 'sample_app'
