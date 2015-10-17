# This file is used by any rack-compatible server and give instructions on how
# to start the server and load the application.

# Loading RackStep
require 'rackstep'
# Loading the application
require_relative './app/app'

# Creates a new instance of the RackStep App class for each request.
run App
