require_relative 'controller'
require_relative 'router'

module RackStep

  class App

    # We will store the request and create a router in this class initializer.
    attr_reader :request, :router

    # Settings is a hash that will be injected into the controller. This hash
    # may contain "global" settings, like a connection to database, and other
    # things that should be initiaized only once while the app is starting.
    attr_accessor :settings

    # Static method called from config.ru ("run App").
    def self.call(env)
      new(env).process_request
    end

    def initialize(env)
      # TODO: Is it ok to leave request as an attribute?
      @request = Rack::Request.new(env)
      @router = RackStep::Router.new
      @settings = RackStep::GlobalConfiguration.instance.settings

      # Adding default routes to handle page not found (404).
      for_all_verbs_add_route('notfound', 'RackStep::ErrorController', 'not_found')
    end

    # TODO: Code Climate says this method is too big.
    def process_request
      verb = request.request_method
      path = request.path

      # In RackStep, each request is processed by a method of a controller. The
      # router is responsable to find, based on the given path and http verb,
      # the apropriate controller and method to handle the request.
      route = router.find_route_for(path, verb)
      # Initialize the correspondent controller.
      controller = Object.const_get(route.controller).new
      # Inject the request into the controller.
      controller.request = request
      # Inject the settings into the controller.
      controller.settings = settings
      # Execute the before method of this controller.
      controller.send(:before)
      # Execute the apropriate method/action.
      controller.send(route.method)
      # Execute the after method of this controller.
      controller.send(:after)
      # Get from the controller what is the response for this request.
      response = controller.response

      return response
    end

    # Adds new routes to the application, one for each possible http verb (GET,
    # POST, DELETE and PUT).
    def for_all_verbs_add_route(path, controller, method)
      @router.add_route('GET', path, controller, method)
      @router.add_route('POST', path, controller, method)
      @router.add_route('DELETE', path, controller, method)
      @router.add_route('PUT', path, controller, method)
    end

    # Adds a new route to the application.
    def add_route(verb, path, controller, method)
      @router.add_route(verb, path, controller, method)
    end

  end

  # Let's extend the Rack Response class to add a few methods to make the life
  # of the developer a little easier.
  class Response < Rack::Response

    # The original body= method of Rack::Response expects an array. In RackStep
    # the user may set it as a String and we will convert it to array if
    # necessary.
    def body=(value)
      if value.is_a?(String)
        # Convert it to an array.
        value = [value]
      end

      super(value)
    end

    def content_type
      header['Content-Type']
    end

    def content_type=(value)
      header['Content-Type'] = value
    end

  end

  # A singleton class with a settings hash attribute wich may be used to
  # to store all 'global' settings (eg: database connections, etc).
  # This settings variable will be injected into every controller
  # by RackStep.
  # TODO: Move to another file and think if this is the best class name.
  class GlobalConfiguration
    include Singleton

    attr_accessor :settings

    def initialize
      @settings = Hash.new
    end

  end

end
