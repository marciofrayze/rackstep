# This sample app will be used by ours tests to check if the RackStep is
# doing what it was supposed to do.

# Loading RackStep files
require_relative '../../lib/rackstep'

# Creating the app class and adding a few routes.
class SampleApp < RackStep::App

  def initialize(env)
    # Must call super first, to initialize all the necessary attributes.
    super(env)

    # Adding a route to requests made to the root of our path and delegating
    # them to the index method of Root controller.
    add_route('GET', '', 'Root', 'index')

    # Adding a route to requests made to a sample json service.
    add_route('GET', 'myJsonService', 'Root', 'myJsonService')

    # Adding route to requests made to a simple html page.
    add_route('GET', 'htmlPage', 'Root', 'htmlPage')
  end

end

# Creating the controller that will process the request.
class Root < RackStep::Controller

  def index
    # RackStep was created mainly to be used for microservices and single page
    # applications, so by default it will set the content type of the response
    # as JSON, but for this example, let's chance that to plain txt.
    # TODO: avoid using attribute to set this
    response[:contentType] = 'text/plain'

    # Anything that is returned by the controller will be the body of the
    # request response back to the user. Let's return a simple string of text.
    response[:content]  = "Welcome to the RackStep Sample App."
  end

  def myJsonService
    # Creating a Hash with some info that we will return to the user as JSON
    user = Hash.new
    user['name'] = 'John Doe'
    user['age'] = '27'
    user['job'] = 'Developer'

    response[:content] = user.to_json
  end

  def htmlPage
    # Overwriting default directory (don't wanna create the whole default
    # folders structure).
    @pagesDirectory = 'test/util/pages'

    response[:content] = render_page('justatestpage')
    response[:contentType] = 'text/html'
  end

end
