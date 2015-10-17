# RackStep

RackStep is (yet another) micro ruby framework for web development.

Main goals are:
- be dead simple.
- keep the source code small.
- implement only the necessary; no overcomplication.
- allow easy implementation of microservices and single-page application (SPA).

If you like ruby frameworks like Sinatra, you may like RackStep.


## Travis-CI status
![alt tag](https://api.travis-ci.org/mfdavid/RackStep.svg)


## Why yet another framework?

Two main reasons:
- I like the principle behind Sinatra, but I dislike the way it is implemented,
so I decided to create an alternative to use it on my side projects.
- I wanted to learn more about how Rack works.


## Dependancies

RackStep is developed and tested with Ruby 2.2.3. The only hard dependency is
Rack itself, but there are a few others recommended gem dependancies:
- unicorn: fast rack-compatible server that can be used for production.
- sanitize: very good and simple lib to sanitize any parameters passed from the user, to avoid sql injection, etc.
- simplecov: a simple way to generate statistics about you unit tests coverage.


## How to

RackStep is not (at least yet) a gem. To create a new application, clone this
repository:
git clone https://github.com/mfdavid/RackStep.git

To run the application, use any rack-compatible server. For development I recommend using shotgun ou rackup. For production, RackStep is pre-configured to use unicorn.


## TODOs (some of them)

- use RDoc or YARD for documentation.
- generate a GEM.
- create more unit tests.
- add some performance tests and do some optimizations.
- solve all the TODOs listed around the source code.


## Author

RackStep is developed by Marcio Frayze David - mfdavid@gmail.com.
