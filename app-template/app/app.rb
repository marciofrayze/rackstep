require 'rackstep'
require_relative 'controllers/root'

class App < RackStep::App

  def initialize(env)
    # Must call super first, to initialize all the necessary attributes.
    super(env)

    add_route('GET', '', 'Root', 'index')
  end

end
