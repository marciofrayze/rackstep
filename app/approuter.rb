# Class responsable for routing the requests.
# DO NOT CHANGE the name of this file and the name of this class. RackStep
# will automatically load this file and initialize this class.

class AppRouter < RackStep::Router

  def initialize
    # Must call super first, to initialize all the necessary attributes.
    super

    # Adding route for main page.
    add_route('GET', '', 'Main', 'index')
  end

end
