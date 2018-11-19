# RackStep

RackStep is (yet another) micro ruby framework for microservices and web development.

Main goals are:
- be as simple as possible.
- keep the source code small.
- implement only the necessary; no overcomplications.
- allow easy implementation of microservices.
- be a pure object-oriented approach, avoiding DSLs and configuration files.


## Status

[![Travis CI](https://api.travis-ci.org/mfdavid/rackstep.svg)](https://travis-ci.org/mfdavid/rackstep)
[![Code Climate](https://codeclimate.com/github/mfdavid/rackstep/badges/gpa.svg)](https://codeclimate.com/github/mfdavid/rackstep)
[![Coverage](https://codeclimate.com/github/mfdavid/rackstep/badges/coverage.svg)](https://codeclimate.com/github/mfdavid/rackstep)
[![Ich CI](http://inch-ci.org/github/mfdavid/rackstep.png)](http://inch-ci.org/github/mfdavid/rackstep)
[![Gem Version](https://badge.fury.io/rb/rackstep.svg)](https://badge.fury.io/rb/rackstep)
[![Downloads](http://ruby-gem-downloads-badge.herokuapp.com/rackstep?type=total&color=brightgreen)](https://rubygems.org/gems/rackstep)

[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/mfdavid/rackstep/blob/master/LICENSE)

[![Twitter](https://img.shields.io/twitter/follow/rackstep.svg?style=social)](https://twitter.com/rackstep)


## A quick introduction to RackStep

[![A quick introduction to RackStep](http://img.youtube.com/vi/MFJut9t5ZLw/0.jpg)](https://www.youtube.com/watch?v=MFJut9t5ZLw "A quick introduction to RackStep.
")

Source code of the presentation:
[github.com/mfdavid/rackstep-presentations](http://github.com/mfdavid/rackstep-presentations)


## Example code

#### Let's create a simple service that returns the current date and time.
```ruby
# app.rb
require 'rackstep'
require 'json'

class TimeController < RackStep::Controller
  def process_request
    time_hash = {:time => Time.now}
    response.body = time_hash.to_json
  end
end

class App < RackStep::App
  # Routing all GET requests to "/time" path to the TimeController class.
  add_route('GET', 'time', TimeController)
end
```
```ruby
# config.ru
require_relative 'app.rb'

run App
```
The service will be available at */time* path and will return the current date and time in *json* format.


## Dependancies

RackStep is developed and tested with Ruby 2.5.3. The only hard dependency is
Rack itself, but there are a few recommended gems:
- puma: fast rack-compatible server that can be used for production.
- simplecov: a simple way to generate statistics about your unit tests coverage.


## How to use RackStep

Make sure you have ruby 2.5.3 installed (ruby --version). If you don't, we recommend you to use [rbenv](https://github.com/sstephenson/rbenv#installation) to install it. RackStep may work with older ruby implementations but we always develop and test with the latest Ruby MRI stable version.

Install the bundle gem if you don't have it already: 
```
gem install bundle
```

To create a new application, you may clone one of the following repositories as a starting point example:

A full app example:
[github.com/mfdavid/rackstep-app-template](https://github.com/mfdavid/rackstep-app-template)

A minimum app example:
[github.com/mfdavid/rackstep-minimum-app-template](https://github.com/mfdavid/rackstep-minimum-app-template)

Go into the directory you cloned the project and install the dependancies by running: 
```
bundle install
```

Start the application server using any rack-compatible server. For development we recommend using shotgun or rackup. RackStep full app template example is pre-configured to use puma in production.


## Running tests

In the main folder of the project, execute:
```
rake test
```

Open coverage/index.html to see the results.


## Author

RackStep is maintained by Marcio Frayze David - mfdavid@gmail.com.
