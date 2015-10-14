require './rackstep/rackstep'

# Configuring Rack to serve static files (html, javascripts, images, etc).
# To have a better performance in production, one good option is to serve this
# type of content using Nginx or Apache servers instead and use rack/ruby only
# for dinamic/business requests.
use Rack::Static,
  :urls => ['/images', '/javascript', '/css', '/fonts', '/pages'],
  :root => 'app/public/'

# Using GZIP on all requests.
# TODO: Check if image requests are also being compressed and avoid it.
use Rack::Deflater

# Creates a new instance of the Dispatcher class for each request.
run RackStep::Dispatcher
