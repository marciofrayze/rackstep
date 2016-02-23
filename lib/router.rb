# Router is one of the fundamental parts of RackStep. It's the router that tell
# us, given a path and a http verb, what controller should handle the business
# logic of the request.

require 'singleton'

module RackStep

  class Router
    
    include Singleton

    # Will store all the possible routes. By default it's empty and should be
    # populated by the application (RackStep will add a 404 route, the others
    # should be added by the user).
    attr_accessor :routes

    def initialize
      @routes = Hash.new
    end

    def add_route(verb, path, controller)     
      route = Route.new(verb, path, controller)
      routes[route.id] = route
    end

    # Given a request, will parse it's path to find what it the apropriate
    # controller to respond it.
    def find_route_for(path, verb)
      # Ignoring the first char if path starts with '/'. This way the path of
      # 'http//localhost/' will be the same of 'http://localhost' (both will
      # be empty strings).
      path = path[1..-1] if path[0] == '/'
      # Re-creating the route id (verb + path).
      route_id = verb + path
      # Getting the correspondent route or nil if route is invalid.
      route = routes[route_id]
      # If no route was found, set it to 'notfound' route (maintaining the
      # original verb).
      route = routes["#{verb}notfound"] if route == nil

      return route
    end

    # Adds new routes to the application, one for each possible http verb (GET,
    # POST, DELETE and PUT).
    def add_route_for_all_verbs(path, controller)
      add_route('GET', path, controller)
      add_route('POST', path, controller)
      add_route('DELETE', path, controller)
      add_route('PUT', path, controller)
    end

  end

end
