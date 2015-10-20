require 'json'

class Root < RackStep::Controller

  def index
    render_page('index')
  end

  def myJsonService
    # Creating a Hash with some info that we will return to the user as JSON
    user = Hash.new
    user['name'] = 'John Doe'
    user['age'] = '27'
    user['job'] = 'Developer'

    return user.to_json
  end

end
