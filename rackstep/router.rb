
module RackStep

  class Router

    attr_accessor :routes

    def initialize
      @routes = Array.new
    end

    def add_route(verb, path, controller, method)
      routes << Route.new(verb, path, controller, method)
    end

    def find_route_for(request)
      # Ignoring the first char if path starts with '/'. This way the path of
      # 'http//localhost/' will be the same of 'http://localhost' (both will
      # be empty strings).
      path = request.path
      path = path[1..-1] if path[0] == '/'
      # Extracting the type of request (GET, POST, PUT, DELETE)
      verb = request.request_method

      route = nil
      # Finding if the given path correspondents to a predefined route.
      # TODO: find a better name for 'r'
      routes.each do | r |
        if r.verb == verb and r.path == path
          route = r
        end
      end
      return route
    end

  end

  class Route

    attr_accessor :verb, :path, :controller, :method

    def initialize(verb, path, controller, method)
      @verb = verb
      @path = path
      @controller = controller
      @method = method
    end

  end

end
