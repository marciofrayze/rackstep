require 'test_helper'

class RoutesTest < RackStepTest

  def test_request_invalid_url_should_return_not_found
    # Given
    invalid_url = '/justAnInvalidServiceRoute'
    # When
    request = @requester.get invalid_url
    # Then
    assert_equal 404, request.status
  end

  def test_request_root_path_should_return_main_page
    # Given
    root_path = '/'
    # When
    request = @requester.get root_path
    # Then
    assert_equal 200, request.status
    assert_equal 'text/plain', request.content_type
    assert_contains "Welcome to the RackStep Sample App", request.body
  end

  def test_request_json_service_should_return_json_service_response_content
    # Given
    json_service_path = '/myJsonService' 
    # When
    request = @requester.get json_service_path
    # Then
    assert_equal 200, request.status
    assert_equal 'application/json', request.content_type
    expected_body = '{"name":"John Doe","age":"27","job":"Developer"}'
    assert_contains expected_body, request.body
  end

  def test_request_erb_page_should_return_html_page_contet
    # Given
    erb_page_path = '/erbPage' 
    # When
    request = @requester.get erb_page_path
    # Then
    assert_equal 200, request.status
    assert_equal 'text/html', request.content_type
    expected_body = 'This is the content of the attribute.'
    assert_contains expected_body, request.body
  end

  def test_request_redirect_url_should_return_redirect_http_status
    # Given
    redirect_url = '/testRedirect'
    # When
    request = @requester.get redirect_url
    # Then
    assert_equal 302, request.status
  end

end
