# Let's extend the Rack Response class to add a few methods to make the life
# of the developer a little easier.

module RackStep

  class Response < Rack::Response

    # The original body= method of Rack::Response expects an array. In RackStep
    # the user may set it as a String and we will convert it to array if
    # necessary.
    def body=(value)
      if value.is_a?(String)
        # Convert it to an array.
        value = [value]
      end

      super(value)
    end

    # Just a helper to get the content type from the response header.
    def content_type
      header['Content-Type']
    end

    # Just a helper to set the content type on the response header.
    def content_type=(value)
      header['Content-Type'] = value
    end

  end

end