
module RackStep

  class Router

    attr_accessor :routes

    def initialize
      @routes = Array.new
    end

    def add_route(path, controller, method)
      routes << Route.new(path, controller, method)
    end

    def find_route_for(path)
      # Ignoring the first char if path starts with '/'. This way the path of
      # 'http//localhost/' will be the same of 'http://localhost' (both will
      # be empty strings).
      path = path[1..-1] if path[0] == '/'

      route = nil
      # Finding if the given path correspondents to a predefined route.
      # TODO: find a better name for 'r'
      routes.each do | r |
        if r.path == path
          route = r
        end
      end
      return route
    end

  end

  class Route

    attr_accessor :path, :controller, :method

    def initialize(path, controller, method)
      @path = path
      @controller = controller
      @method = method
    end

  end

end
