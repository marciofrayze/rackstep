# Testing RackStep framework.
# Testing if basic access authentication is working properly.

require_relative 'util/rackstep_test'

class BasicAuthRoutesTest < RackStepTest

  # Testing invalid credentials (none).
  def test_access_to_protected_page_passing_no_credentials
    # Requesting the protectedPage of the application.
    uri = URI.escape('/protectedPage')
    request = @requester.get(uri)
    # The response should be Unauthorized (401).
    assert_equal 401, request.status
    # Content type should be HTML
    assert_equal 'text/html', request.content_type
    # Should contain a header with 'WWW-Authenticate'.
    assert request.headers['WWW-Authenticate'] != nil
    # Checking if the response contains the expected text.
    expected_body = 'Access Denied'
    assert_contains expected_body, request.body
  end

  # Testing valid credentials.
  def test_access_to_protected_page_passing_right_credentials
    # Requesting the protectedPage of the application.
    request = @requester.get( URI.escape('/protectedPage'),
                              { 'HTTP_AUTHORIZATION'=> encode_credentials('myBoringUsername', 'myBoringPassword') } )

    # The response should be OK (200)
    assert_equal 200, request.status
    # Content type should be HTML
    assert_equal 'text/html', request.content_type
    # Should not contain a header with 'WWW-Authenticate'.
    assert request.headers['WWW-Authenticate'] == nil
    # Checking if the response contains the expceted text
    expected_body = 'Welcome! You are now logged in.'
    assert_contains expected_body, request.body
  end

  # Testing invalid credentials (wrong username and password)
  def test_access_to_protected_page_passing_wrong_credentials
    # Requesting the protectedPage of the application.
    request = @requester.get( URI.escape('/protectedPage'),
                              { 'HTTP_AUTHORIZATION'=> encode_credentials('myWrongUsername', 'myWrongPassword') } )

    # The response should be OK (200)
    assert_equal 401, request.status
    # Content type should be HTML
    assert_equal 'text/html', request.content_type
    # Should contain a header with 'WWW-Authenticate'.
    assert request.headers['WWW-Authenticate'] != nil
    # Checking if the response contains the expected text.
    expected_body = 'Access Denied'
    assert_contains expected_body, request.body
  end

end
