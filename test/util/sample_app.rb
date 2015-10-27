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

    # Route to requests made to a sample json service.
    add_route('GET', 'myJsonService', 'Root', 'my_json_service')

    # Route to requests made to a simple html page.
    add_route('GET', 'htmlPage', 'Root', 'html_page')

    # Route to requests made to a service for testing the 'global' settings.
    add_route('GET', 'settingsTest', 'Root', 'settings_test_service')

    # Route to requests made to a page that renders an ERB template.
    add_route('GET', 'erbPage', 'Root', 'erb_page')

    # Route to requests made to basic access authentication page.
    add_route('GET', 'protectedPage', 'Root', 'protected_page')

    # Route to request made to before and after methods test service.
    add_route('GET', 'beforeAndAfter', 'Root', 'before_and_after')

  end

end

# Creating the controller that will process the requests.
class Root < RackStep::Controller

  include RackStep::Controller::HtmlRendering
  include RackStep::Controller::ErbRendering
  include RackStep::Controller::BasicHttpAuthentication

  # Overwriting the before method to test if it's working properly.
  def before
    # Will add something to the settings, so I can check in my test if this
    # method was executed when it was supposed to.
    settings[:before_after] = settings[:before_after].to_s + "Before"
  end

  # Overwriting the after method to test if it's working properly.
  def after
    # Will add something to the settings, so I can check in my test if this
    # method was executed when it was supposed to.
    settings[:before_after] = settings[:before_after].to_s + "After"
  end

  def index
    # RackStep was created mainly to be used for microservices and single page
    # applications, so by default it will set the content type of the response
    # to JSON, but for this example, let's chance that to plain txt.
    response.content_type = 'text/plain'

    # Let's set as the body of the response a simple string of text.
    response.body = 'Welcome to the RackStep Sample App.'
  end

  def my_json_service
    # Creating a Hash with some info that we will return to the user as JSON
    user = Hash.new
    user['name'] = 'John Doe'
    user['age'] = '27'
    user['job'] = 'Developer'

    response.body = user.to_json
  end

  def html_page
    # Overwriting default directory (don't wanna create the whole default
    # folders structure).
    pages_directory = 'test/util/pages'

    response.body = render_page('justatestpage', pages_directory)
    response.content_type = 'text/html'
  end

  def settings_test_service
    # At the initialize of sampleApp we set a :config. Lets retrieve it and
    # send back as the body of our response.

    response.body = settings[:test]
  end

  # Let's render an ERB template to test the RackStep::ErbRendering module.
  def erb_page
    erb_templates_directory = 'test/util/pages'

    # Every attribute should be available for the template. In our case, it is
    # expecting to find the following attribute:
    @templateAttributeTest = 'This is the content of the attribute.'
    response.body = render_erb('justatesttemplate', erb_templates_directory)
    response.content_type = 'text/html'
  end

  def before_and_after
    # This service was created to test if the before and after execution was
    # working properly. The sample app will set a variable at the 'global'
    # settings hash (settings[:before_after]). Here I will return the content
    # that variable.
    settings[:before_after] = settings[:before_after].to_s + "During"
  end

  def protected_page
    response.content_type = 'text/html'

    credentials = basic_access_authentication_credentials
    if credentials != ['myBoringUsername', 'myBoringPassword']
      # TODO: Make life easier for the app developer.
      response.status = 401
      response.body = 'Access Denied'
      # In a real life application you must set this header so the browser
      # knows that it should ask for the username and password.
      response.headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    else
      # The credentials are fine! Let's show the page content.
      response.body = 'Welcome! You are now logged in.'
    end
  end

end
