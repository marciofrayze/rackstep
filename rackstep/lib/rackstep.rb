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
    end

    def process_request
      # Trying to find what controller should process this request.
      # This will return a hash with the name of the controller, the
      # method (action), etc.
      route = router.find_route_for(request)
      # If no valid route is found, will break the request and return http 404
      # (page not found).
      if (route == nil)
        return page_not_found_response
      end
      # Initialize the correspondent controller
      controller = Object.const_get(route.controller).new
      # Inject the request into the Controller
      controller.request = request
      # Execute the before method of this controller
      controller.send(:before)
      # Execute the apropriate method/action
      response_content = controller.send(route.method)
      # Generate a rack response that will be returned to the user
      Rack::Response.new(response_content, 200, {'Content-Type' => controller.content_type})
    end

    def page_not_found_response
      Rack::Response.new("404 - Page not found", 404)
    end

    # Adds a new route to the application.
    def add_route(verb, path, controller, method)
      @router.add_route(verb, path, controller, method)
    end

  end

end
