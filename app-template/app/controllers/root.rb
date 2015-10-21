require 'json'

class Root < RackStep::Controller

  def index
    response[:content] = render_page('index')
  end

  def myJsonService
    # Creating a Hash with some info that we will return to the user as JSON
    # (simulating a service).
    user = Hash.new
    user['name'] = 'John Doe'
    user['age'] = '27'
    user['job'] = 'Developer'

    response[:content] = user.to_json
  end

end
