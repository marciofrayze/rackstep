# Abstract controller class with some helper methods. ALL your controllers
# MUST use this one as a superclass.

module RackStep

  class Controller

    # The request will be injected here.
    attr_accessor :request

    # The Rack::Response object that will be delivered to the user.
    attr_accessor :response

    # The 'global' app settings will be injected here. This hash variable is
    # initialized only once (singleton) and may contain references to things
    # that should be initialize only once during the app start (eg: database
    # connection).
    attr_accessor :settings

    def initialize
      @response = RackStep::Response.new
      @response.body = ''
      @response.content_type = 'application/json'
      @response.status = 200
    end

    # Once the application receives a new request, the router will decide wich
    # controller should process that request and will execute this method for
    # the chosen controller. So this is the most important method of this class
    # and every controller should overwrite it to implement it's business
    # logic.
    def process_request
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


  # This controller will handle error the error "page not found". The user may
  # overwrite this by creating new route to 'notfound'.
  # TODO: Find a better name for this class.
  class NotFoundController < RackStep::Controller

    def process_request
      @response.body = '404 - Page not found'
      @response.content_type = 'text/plain'
      @response.status  = 404
    end

  end

end

# A module for controllers to add static html pages rendering.
# This is not the best way to serve static content. In production, consider
# using Nginx or Apache. Using ruby/rack to serve static content is a waste
# of resources and should be only used for low traffic web pages. This
# method is provided so that in this circumstances you may use it to keep a
# simpler architecture.
module RackStep::Controller::HtmlRendering
  def render_page(page_name, pages_directory = 'app/public/pages')
    File.read("#{pages_directory}/#{page_name}.html")
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
