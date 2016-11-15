# This is the default action that will handle the "page internal server error" (500) if a process_request didnt implemented. 
class ProcessRequestor

  # Once the application receives a new request, the router will decide wich
  # controller should process that request and will execute this method for
  # the chosen controller. So this is the most important method of this class
  # and every controller should overwrite it to implement it's business
  # logic.
  def process_request
    @response.body = '500 - Internal Server Error'
    @response.content_type = 'text/plain'
    @response.status = 500
  end

end

# Abstract controller class with some helper methods. ALL your controllers
# MUST use this one as a superclass.

class RackStep::Controller < ProcessRequestor

  # The request will be injected here.
  attr_accessor :request

  # The Rack::Response object that will be delivered to the user.
  attr_accessor :response

  def initialize
    @response = RackStep::Response.new
    @response.body = ''
    @response.content_type = 'application/json'
    @response.status = 200
  end

  # RackStep will always execute this method before delegating the request
  # processing to the specified controller. The user may overwrite this method.
  # This may be usefull if the user wants to create an abstract controllers.
  # TODO: Is this really necessary?
  def before
  end

  # RackStep will always execute this method after processing the request
  # of to the specified controller. The user may overwrite this method.
  # This can be used to check for logging or any piece of code
  # that must be executed after every request for this controller.
  # This may be usefull if the user wants to create an abstract controllers.
  # TODO: Is this really necessary?
  def after
  end

end

# This is the default controller that will handle the "page not found" (404). 
# The user may overwrite this by creating new route to 'notfound'.
class RackStep::NotFoundController < RackStep::Controller

  def process_request
    @response.body = '404 - Page not found'
    @response.content_type = 'text/plain'
    @response.status = 404
  end

end


# A module for controllers to add ERB template rendering. RackStep is not meant
# to be used for template rendering. We recommend you to use a SPA (Single Page
# Application) approach. But if you want to, you may include this module into
# your controller and render ERB templates, following the old ruby web way.
# TODO: Add layout support.
module RackStep::Controller::ErbRendering

  require 'erb'

  def render_erb(template_name, erb_template_directory = 'app/public/pages')
    template_path = "#{erb_template_directory}/#{template_name}.erb"
    erb = ERB.new(File.open(template_path).read)
    return erb.result(binding)
  end

end


# A module for controllers to add basic http authentication helper method.
module RackStep::Controller::BasicHttpAuthentication

  def basic_access_authentication_credentials
    credentials = nil
    # Trying to get the basic http authentication credentials from the request.
    auth = Rack::Auth::Basic::Request.new(request.env)
    if auth.provided? and auth.basic? and auth.credentials
      credentials = auth.credentials
    else
      # No credentials found. Will return empty to avoid returning nil.
      credentials = ['', '']
    end

    return credentials
  end

end
