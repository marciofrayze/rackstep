# Router is one of the fundamental parts of RackStep. It's the router that tell
# us, given a path and a http verb, what controller should handle the business
# logic of the request.
module RackStep

  class Router

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

  end

  # Represents a single route. The verb can be 'GET', 'PUT', 'POST' or 'DELETE'.
  # The path is a string with something like 'users', the controller is the
  # name of the class that will process this type of request.
  class Route

    attr_accessor :verb, :path, :controller

    def initialize(verb, path, controller)
      @verb = verb
      @path = path
      @controller = controller
    end

    # Unique id of the route (verb + path). Eg: 'GETuser'.
    def id
      verb + path
    end

  end

end
