require 'rackstep'

# Defining the app class that will be instanciated by the rack server and adding
# a single route.
class App < RackStep::App

  def initialize(env)
    # Must call super first, to initialize all the necessary attributes.
    super(env)

    add_route('GET', '', 'Root', 'index')
  end

end

# Defining the controller that will process the request.
class Root < RackStep::Controller

  def index
    # RackStep was created to server microservices and single page applications,
    # so by default it will set the content type of the response as JSON, but
    # for this example, let's chance that to plain txt.
    content_type = 'text/plain'

    # Anything that is returned by the controller will be the body of the
    # request response back to the user. Let's return a simple string of text.
    "Welcome to the RackStep minimum app template."
  end

end
