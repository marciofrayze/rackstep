# Extending the Rack::Response class to add a few methods to make the life
# of the developer a little easier.

module RackStep

  class Response < Rack::Response

    # The original body= method of Rack::Response expects an array. In RackStep
    # the user may set it as a String and we will convert it to array if
    # necessary.
    def body=(value)
      if value.is_a?(String)
        value = [value]
      end

      super(value)
    end

    # Helpers
    def content_type
      header['Content-Type']
    end
    def content_type=(value)
      header['Content-Type'] = value
    end
    def redirect_to(address)
      @status = 302
      header['Location'] = address
    end

  end

end
