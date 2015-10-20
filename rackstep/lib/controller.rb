# Abstract controller class with some helper methods. ALL your controllers
# MUST use this one as a superclass.

module RackStep

  class Controller

    # The request will be injected here.
    attr_accessor :request
    # Stores the content type that will be used for the response.
    attr_accessor :content_type

    def initialize
      # The default response content type is json, but may be altered.
      @content_type = 'application/json'
    end

    # RackStep will always execute this method before delegating the request
    # processing to the specified method. The user may overwrite this method.
    # This can be used to check for access authorization or any piece of code
    # that must be executed before every request for this controller.
    def before
    end

    # This is not the best way to serve static content. In production, consider
    # using Nginx or Apache. Using ruby/rack to serve static content is a waste
    # of resources and should be only used for low traffic web pages. This
    # method is provided so that in this circumstances you may use it to keep a
    # simpler architecture.
    def render_page(pageName)
      @content_type = 'text/html'
      # TODO: remove hard-coded directory
      File.read("app/public/pages/#{pageName}.html")
    end

  end

end
