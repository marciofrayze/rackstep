# This sample app will be used by ours tests to check if the RackStep is
# doing what it was supposed to do.

# Loading RackStep files.
require_relative '../../lib/rackstep'

# Creating the app class and adding a few routes.
class SampleApp < RackStep::App

  # Adding a route to requests made to the root of our path and delegating
  # them to SimplePlainTextService controller.
  add_route('GET', '', 'SimplePlainTextService')

  # Route to requests made to a sample json service.
  add_route('GET', 'myJsonService', 'JsonService')

  # Route to requests made to a simple html page.
  add_route('GET', 'htmlPage', 'SimpleHtmlPage')

  # Route to requests made to a service for testing the 'global' settings.
  add_route('GET', 'settingsTest', 'SimpleSettingsRetrieveService')

  # Route to requests made to a page that renders an ERB template.
  add_route('GET', 'erbPage', 'SimpleErbPage')

  # Route to requests made to basic access authentication page.
  add_route('GET', 'protectedPage', 'BasicHttpAuthenticationProtectedPage')

  # Route to request made to before and after methods test service.
  add_route('GET', 'beforeAndAfter', 'BeforAndAfterSettingsService')
  
  def initialize(env)
    # Must call super first, to initialize all the necessary attributes.
    super(env)

    # Adding something to the 'global' setting. This will be injected into all
    # controllers. The reason there is an if at the end is that this peace of
    # code (SampleApp initialize) is executed many times (once every request)
    # but since settings is a singleton, we only have to set it once. After the
    # first request, the variable should be already setted. Anything that is
    # setted in the settings hash will be persisted "forever" and is shared
    # across multiple requests.
    settings[:test] = "This is just a settings test." if settings[:test] == nil

  end

end


# Creating the controller that will process the requests for testing a very
# simple text/plain response.
class SimplePlainTextService < RackStep::Controller
  def process_request
    # RackStep was created mainly to be used for microservices and single page
    # applications, so by default it will set the content type of the response
    # to JSON, but for this example, let's chance that to plain txt.
    response.content_type = 'text/plain'

    # Let's set as the body of the response a simple string of text.
    response.body = 'Welcome to the RackStep Sample App.'
  end
end


# Creating the controller that will process the requests for testing a
# simulated json service.
class JsonService < RackStep::Controller
  def process_request
    # Creating a Hash with some info that we will return to the user as JSON
    user = Hash.new
    user['name'] = 'John Doe'
    user['age'] = '27'
    user['job'] = 'Developer'

    response.body = user.to_json
  end
end


# Creating the controller that will process the requests for testing a simple
# html page.
class SimpleHtmlPage < RackStep::Controller

  include RackStep::Controller::HtmlRendering

  def process_request
    # Overwriting default directory (don't wanna create the whole default
    # folders structure).
    pages_directory = 'test/util/pages'

    response.body = render_page('justatestpage', pages_directory)
    response.content_type = 'text/html'
  end
end


# Creating the controller that will process the requests for testing the 'glboal'
# settings.
class SimpleSettingsRetrieveService < RackStep::Controller
  def process_request
    # At the initialize of sampleApp we set a :config. Lets retrieve it and
    # send back as the body of our response.
    response.body = settings[:test]
  end
end


# Creating the controller that will process the requests for testing an ERB
# template page.
class SimpleErbPage < RackStep::Controller

  include RackStep::Controller::ErbRendering

  # Let's render an ERB template to test the RackStep::ErbRendering module.
  def process_request
    erb_templates_directory = 'test/util/pages'

    # Every attribute should be available for the template. In our case, it is
    # expecting to find the following attribute:
    @templateAttributeTest = 'This is the content of the attribute.'
    response.body = render_erb('justatesttemplate', erb_templates_directory)
    response.content_type = 'text/html'
  end
end


# Creating the controller that will process the requests for testing basic http
# authentication.
class BasicHttpAuthenticationProtectedPage < RackStep::Controller

  include RackStep::Controller::BasicHttpAuthentication

  def process_request
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


# Creating the controller that will process the requests for testing if the
# before and after methods are executed as expected.
class BeforAndAfterSettingsService < RackStep::Controller
  # Overwriting the before method to test if it's working properly.
  def before
    # Will set something to the settings, so I can check in my test if this
    # method was executed when it was supposed to.
    settings[:before_after] = settings[:before_after].to_s + "Before"
  end

  # Overwriting the after method to test if it's working properly.
  def after
    # Will add something to the settings, so I can check in my test if this
    # method was executed when it was supposed to.
    settings[:before_after] = settings[:before_after].to_s + "After"
  end

  def process_request
    # This service was created to test if the before and after execution was
    # working properly. The sample app will set a variable at the 'global'
    # settings hash (settings[:before_after]). Here I will return the content
    # that variable.
    settings[:before_after] = settings[:before_after].to_s + "During"
  end
end