# This sample app will be used by ours tests to check if the RackStep is
# doing what it was supposed to do.

# Loading RackStep files.
require_relative '../../lib/rackstep'


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
# simulated JSON service.
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


# Creating the controller that will process the requests for testing an ERB
# template page.
class SimpleErbPage < RackStep::Controller

  include RackStep::Controller::ErbRendering

  # Let's render an ERB template to test the RackStep::ErbRendering module.
  def process_request
    # Overwriting default directory (don't wanna create the whole default
    # folders structure).
    erb_templates_directory = 'test/util/pages'

    # Every attribute should be available for the template. In our case, it is
    # expecting to find the following attribute:
    @templateAttributeTest = 'This is the content of the attribute.'

    # Rendering the template.
    response.body = render_erb('justatesttemplate', erb_templates_directory)

    # Setting this request content type as html.
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
      # In a real life application you must set this header so the browser knows
      # that it should ask for the username and password.
      response.headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    else
      # The credentials are fine! Let's show the page content.
      response.body = 'Welcome! You are now logged in.'
    end
  end

end


# A controller for testing the redirect_to.
class Redirector < RackStep::Controller
  def process_request
    response.redirect_to('/anotherService')
  end
end


# Creating the controller that wont implement the process_request method
class ProcessRequestorNotImplemented < RackStep::Controller
end


# Creating the app class and adding a few routes.
class SampleApp < RackStep::App

  # Adding a route to requests made to the root of our path and delegating
  # them to SimplePlainTextService controller.
  add_route('GET', '', SimplePlainTextService)

  # Route to requests made to a sample json service.
  add_route('GET', 'myJsonService', JsonService)

  # Route to requests made to a page that renders an ERB template.
  add_route('GET', 'erbPage', SimpleErbPage)

  # Route to requests made to basic access authentication page.
  add_route('GET', 'protectedPage', BasicHttpAuthenticationProtectedPage)

  # Route to test redirect_to.
  add_route('GET', 'testRedirect', Redirector)

  # Route to test controller that didnt implemented process_request.
  add_route('GET', 'processRequestorNotImplemented', ProcessRequestorNotImplemented)
end


# TODO: Test before and after methods
