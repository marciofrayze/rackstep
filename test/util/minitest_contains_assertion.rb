# Extending the Minitest framework to add a new assertion method (contains).

module Minitest::Assertions
  def assert_contains(exp_substr, obj, msg=nil)
    msg = message(msg) { "Expected #{mu_pp obj} to contain #{mu_pp exp_substr}" }
    assert_respond_to obj, :include?
    assert obj.include?(exp_substr), msg
  end
end
