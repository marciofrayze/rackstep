# A singleton class with a settings hash attribute wich may be used to
# to store all 'global' settings (eg: database connections, etc).
# This settings variable will be injected into every controller
# by RackStep.
class RackStep::GlobalConfiguration

  include Singleton

  attr_accessor :settings

  def initialize
    @settings = Hash.new
  end

end