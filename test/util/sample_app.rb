# This sample app will be used by ours tests to check if the RackStep is
# doing what it was supposed to do.

# Loading RackStep files
require_relative '../../lib/rackstep'

# Creating the app class and adding a few routes.
class SampleApp < RackStep::App

  def initialize(env)
    # Must call super first, to initialize all the necessary attributes.
    super(env)

    # Adding something to the 'global' setting. This will be injected into all
    # controllers.
    settings[:test] = "This is just a settings test."

    # Adding a route to requests made to the root of our path and delegating
    # them to the index method of Root controller.
    add_route('GET', '', 'Root', 'index')

    # Adding a route to requests made to a sample json service.
    add_route('GET', 'myJsonService', 'Root', 'my_json_service')

    # Adding route to requests made to a simple html page.
    add_route('GET', 'htmlPage', 'Root', 'html_page')

    # Adding route to requests made to a service for testing the 'global'
    # settings.
    add_route('GET', 'settingsTest', 'Root', 'settings_test_service')

    # Adding route to requests made to a page that renders an ERB template.
    add_route('GET', 'erbPage', 'Root', 'render_erb_test')

    # Adding route to requests made to basic access authentication page.
    add_route('GET', 'protectedPage', 'Root', 'protected_page')

  end

end

# Creating the controller that will process the request.
class Root < RackStep::Controller

  include RackStep::ErbRendering
  include RackStep::BasicHttpAuthentication

  def index
    # RackStep was created mainly to be used for microservices and single page
    # applications, so by default it will set the content type of the response
    # as JSON, but for this example, let's chance that to plain txt.
    response[:type] = 'text/plain'

    # Anything that is returned by the controller will be the body of the
    # request response back to the user. Let's return a simple string of text.
    response[:content]  = "Welcome to the RackStep Sample App."
  end

  def my_json_service
    # Creating a Hash with some info that we will return to the user as JSON
    user = Hash.new
    user['name'] = 'John Doe'
    user['age'] = '27'
    user['job'] = 'Developer'

    response[:content] = user.to_json
  end

  def html_page
    # Overwriting default directory (don't wanna create the whole default
    # folders structure).
    pages_directory = 'test/util/pages'

    response[:content] = render_page('justatestpage', pages_directory)
    response[:type] = 'text/html'
  end

  def settings_test_service
    # At the sample_app.rb we set a :config. Lets retrieve it and send back as
    # a response.

    response[:content] = settings[:test]
  end

  def render_erb_test
    # Let's render an ERB template to test the RackStep::ErbRendering module.
    pages_directory = 'test/util/pages'

    @templateAttributeTest = "This is the content of the attribute."
    response[:content] = render_erb('justatesttemplate', pages_directory)
    response[:type] = 'text/html'
  end

  def protected_page
    response[:type] = 'text/html'

    credentials = basic_access_authentication_credentials
    if credentials != ['myBoringUsername', 'myBoringPassword']
      # TODO: Make life easier for the app developer.
      response[:httpStatus] = 401
      response[:content] = "Access Denied"
      response[:headers]['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      return
    end

    response[:content] = "Welcome! You are now logged in."
  end

end
