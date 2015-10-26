# Abstract controller class with some helper methods. ALL your controllers
# MUST use this one as a superclass.

module RackStep

  class Controller

    # The request will be injected here.
    attr_accessor :request

    # Represents the response information that will be delivered to the user
    # (a Hash with type, content and httpStatus).
    # By default httpStatus is 200 and type is application/json.
    attr_accessor :response

    # The 'global' app settings will be injected here. This may contain
    # references to things that should be initialize only once during the app
    # start (eg: database connection).
    attr_accessor :settings

    def initialize
      # TODO: Maybe create a RackStep::Response class?
      @response = Hash.new
      @response[:type] = 'application/json'
      @response[:httpStatus]  = 200
      @response[:content] = ''
      @response[:headers] = Hash.new
    end

    # RackStep will always execute this method before delegating the request
    # processing to the specified method. The user may overwrite this method.
    # This can be used to check for access authorization or any piece of code
    # that must be executed before every request for this controller.
    def before
    end

    # Since headers is a hash, when using it directly the syntax is a little
    # wierd, so let's create an alias for it
    def headers
      @response[:headers]
    end

    # This is not the best way to serve static content. In production, consider
    # using Nginx or Apache. Using ruby/rack to serve static content is a waste
    # of resources and should be only used for low traffic web pages. This
    # method is provided so that in this circumstances you may use it to keep a
    # simpler architecture.
    # TODO: Move this to a module.
    def render_page(page_name, pages_directory = 'app/public/pages')
      File.read("#{pages_directory}/#{page_name}.html")
    end

  end

  # This controller will handle error the error "page not found". The user may
  # overwrite this by creating new router to 'notfound'.
  class ErrorController < RackStep::Controller

    def not_found
      @response[:type] = 'text/plain'
      @response[:httpStatus]  = 404
      @response[:content] = '404 - Page not found'
    end

  end

end

# A module for controllers to add ERB template rendering. RackStep is not meant
# to be used for template rendering. We recommend you to use a SPA (Single Page
# Application) approach. But if you want to, you may include this module into
# your controller and render ERB templates, following the old ruby web way.
# TODO: Add layout support.
module RackStep::ErbRendering

  require 'erb'

  def render_erb(template_name, pages_directory = 'app/public/pages')
    template_path = "#{pages_directory}/#{template_name}.erb"
    erb = ERB.new(File.open(template_path).read)
    return erb.result(binding)
  end

end


# A module for controllers to add basic http authentication.
module RackStep::BasicHttpAuthentication

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
