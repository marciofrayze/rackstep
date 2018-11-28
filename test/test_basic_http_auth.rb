require_relative 'util/rackstep_test'

class BasicAuthTest < RackStepTest

  def test_request_protected_url_with_no_credentials_should_return_denied
    # Given
    uri = '/protectedPage'
    # When
    request = @requester.get(uri)
    # Then
    assert_equal 401, request.status
    assert_equal 'text/html', request.content_type
    assert request.headers['WWW-Authenticate'] != nil
    expected_body = 'Access Denied'
    assert_contains expected_body, request.body
  end

  def test_request_protected_url_with_right_credentials_should_return_the_page
    # Given
    right_credentials = encode_credentials('myBoringUsername', 'myBoringPassword')
    # When
    request = @requester.get( '/protectedPage',
                              { 'HTTP_AUTHORIZATION'=> right_credentials } )
    # Then
    assert_equal 200, request.status
    assert_equal 'text/html', request.content_type
    assert request.headers['WWW-Authenticate'] == nil
    expected_body = 'Welcome! You are now logged in.'
    assert_contains expected_body, request.body
  end

  def test_request_protected_url_with_wrong_credentials_should_return_denied
    # Given
    wrong_credentials = encode_credentials('myWrongUsername', 'myWrongPassword')
    # When
    request = @requester.get( '/protectedPage',
                              { 'HTTP_AUTHORIZATION'=> wrong_credentials } )
    # Then
    assert_equal 401, request.status
    assert_equal 'text/html', request.content_type
    assert request.headers['WWW-Authenticate'] != nil
    expected_body = 'Access Denied'
    assert_contains expected_body, request.body
  end

end
