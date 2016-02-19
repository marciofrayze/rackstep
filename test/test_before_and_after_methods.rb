# Testing RackStep framework. In this file we will test the before and after
# controller method.

require 'test_helper'

class ControllerBeforeAndAfterExecutionTest < RackStepTest

  # Test if rackstep is running the before and after methods as expected.
  # In this test we will instantiate and run a SampleApp ourselves (will not
  # use a route for that).
  # How this test works: at our sample app we added a before and an after method
  # in our controller. They add strings to the 'global' settings[:before_after]
  # variable. We also created a service called beforeAndAfter wich also adds
  # a string to the same variable. So we expect the before method to run first,
  # then the controller itself and at last the after. At this test we check if
  # the order that the strings concatenated follow this behaviour.
  def test_before_and_after_methods
    # Fake/mock env variable to not break the execution.
    env =  { "REQUEST_METHOD"=>"GET", "PATH_INFO"=>"/beforeAndAfter" }
    app = SampleApp.new(env)
    response = app.process_request
    assert_equal response.content_type, 'application/json'
    assert_equal app.settings[:before_after], "BeforeDuringAfter"
  end

end
