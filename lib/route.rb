  # Represents a single route. The verb can be 'GET', 'PUT', 'POST' or 'DELETE'.
  # The path is a string with something like 'users', the controller is the
  # name of the class that will process this type of request.

  module RackStep

    class Route

      attr_accessor :verb, :path, :controller

      def initialize(verb, path, controller)
        @verb = verb
        @path = path
        @controller = controller
      end

      # Unique id (String) of the route (verb + path). Eg: 'GETuser'.
      def id
        verb + path
      end

    end

end