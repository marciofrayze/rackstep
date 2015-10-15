# This file will be required as soon as the Rack Step is loaded. You may here
# include everything you need for your app.

require './rackstep/rackstep'

# Loading all the app controllers
Dir[File.dirname(__FILE__) + '/controllers/*.rb'].each { |file| require file }
