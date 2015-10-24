require_relative 'controller'
require_relative 'router'

module RackStep

  class App

    # We will store the request and create a router in this class initializer.
    attr_reader :request, :router

    # Static method called from config.ru ("run App").
    def self.call(env)
      new(env).process_request
    end

    def initialize(env)
      @request = Rack::Request.new(env)
      @router = RackStep::Router.new

      # Adding default routes to handle page not found (404).
      for_all_verbs_add_route('notfound', 'RackStep::ErrorController', 'not_found')
    end

    def process_request
      verb = @request.request_method
      path = @request.path

      # In RackStep, each request is processed by a method of a controller. The
      # router is responsable to find, based on the given path and http verb,
      # the apropriate controller and method to handle the request.
      route = router.find_route_for(path, verb)
      # Initialize the correspondent controller.
      controller = Object.const_get(route.controller).new
      # Inject the request into the Controller.
      controller.request = request
      # Execute the before method of this controller.
      controller.send(:before)
      # Execute the apropriate method/action.
      controller.send(route.method)
      # Get from the controller what is the response for this request.
      response = controller.response
      # Generate a rack response that will be returned to the user.
      Rack::Response.new( response[:content],
                          response[:httpStatus],
                          {'Content-Type' => response[:contentType]} )
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

end
