# In this file you will find the RackStep::App class.
# This is one of the fundamental parts of the framework and
# is responsable for the whole orchestration.
# To use RackStep one of the first things you will have to
# do is extend this class.

require 'rack'
require_relative 'response'
require_relative 'route'
require_relative 'router'
require_relative 'controller'

module RackStep

  # Abstract class with the base of a RackStep app. 
  # This class MUST be extended by the user.
  class App

    # Will store the received request which will be injected into the user controllers.
    attr_reader :request

    # Router is a singleton that will store all the registred routes.
    def router
      Router.instance
    end

    # Static method called from config.ru ("run App").
    def self.call(env)
      new(env).process_request
    end

    # Initialize all instance variables and add a default "not found" route.
    def initialize(env)
      @request = Rack::Request.new(env)

      # Adding default routes to handle page not found (404).
      router.add_route_for_all_verbs('notfound', 'RackStep::NotFoundController')
    end

    # TODO: Code Climate says this method is too big.
    def process_request
      verb = request.request_method
      path = request.path

      # In RackStep, each request is processed by a controller. The router 
      # is responsable to find, based on the given path and http verb,
      # the apropriate controller to handle the request.
      route = router.find_route_for(path, verb)
      # Initialize the correspondent controller.
      controller = Object.const_get(route.controller).new
      # Inject the request into the controller.
      controller.request = request
      # Execute the before method of this controller.
      controller.send(:before)
      # Execute the apropriate method/action.
      controller.send(:process_request)
      # Execute the after method of this controller.
      controller.send(:after)
      # Get from the controller what is the response for this request.
      response = controller.response

      return response
    end

    # This method was created to make it easier for the user to add routes, but it 
    # will delegate to the router singleton class.
    def self.add_route(verb, path, controller)
      router = Router.instance
      router.add_route(verb, path, controller)
    end

  end

end
