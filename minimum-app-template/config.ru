# This file is used by any rack-compatible server and gives instructions on how
# to start the server and load the application.

# Loading RackStep
require 'rackstep'
# Loading the application
require_relative './app/app'

# Inform rack server to create a new instance of the App class for each request.
run App
