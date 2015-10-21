require 'rackstep'

# Creating the app class that will be instanciated by the rack server and adding
# a single route.
class App < RackStep::App

  def initialize(env)
    # Must call super first, to initialize all the necessary attributes.
    super(env)

    # Adding a route to requests made to the root of our path and delegating
    # them to the index method of Root controller.
    add_route('GET', '', 'Root', 'index')
  end

end

# Creating the controller that will process the request.
class Root < RackStep::Controller

  def index
    # RackStep was created mainly to be used for microservices and single page
    # applications, so by default it will set the content type of the response
    # as JSON, but for this example, let's chance that to plain txt.
    response[:contentType] = 'text/plain'

    # Let's return a simple string of text as the content of the response.
    response[:content] = "Welcome to the RackStep minimum app template."
  end

end
