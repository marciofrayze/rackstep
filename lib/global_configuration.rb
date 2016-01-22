# A singleton class with a settings hash attribute which may be used to
# to store all 'global' settings (eg: database connections, etc).
# This settings variable will be injected into every controller
# by RackStep.

class RackStep::GlobalConfiguration

  # One and only one instance of this class will exist. To retrieve it,
  # we use RackStep::GlobalConfiguration.instance, but please DO NOT
  # get it this way. The settings hash will be available to you in the 
  # controller and you should access it with the "settings" object that
  # is inject into your controller.
  # To see how to use it, please take a look at sample_app.rb initialize 
  # method and SimpleSettingsRetrieveService controller class.
  include Singleton

  attr_accessor :settings

  # Defines a Hash where the settings shall be stored.
  def initialize
    @settings = Hash.new
  end

end