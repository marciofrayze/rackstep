# Abstract controller class with some helper methods. ALL your controllers
# MUST use this one as a superclass.

module RackStep

  class Controller

    # The request will be injected here.
    attr_accessor :request
    # Represents the response information that will be delivered to the user
    # (a Hash with contentType, content and httpStatus).
    # By default httpStatus is 200 and contentType is application/json.
    attr_accessor :response

    def initialize
      @response = Hash.new
      @response[:contentType] = 'application/json'
      @response[:httpStatus]  = 200
      @response[:content] = ''
      @pagesDirectory = 'app/public/pages'
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
      response[:contentType] = 'text/html'
      File.read("#{@pagesDirectory}/#{pageName}.html")
    end

  end

end
