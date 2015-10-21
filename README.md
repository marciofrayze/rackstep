# RackStep

RackStep is (yet another) micro ruby framework for microservices and web development.

Main goals are:
- be as simple as possible.
- keep the source code small.
- implement only the necessary; no overcomplication.
- allow easy implementation of microservices and single-page application (SPA).


## Travis-CI status
![alt tag](https://api.travis-ci.org/mfdavid/RackStep.svg)


## Dependancies

RackStep is developed and tested with Ruby 2.2.3. The only hard dependency is
Rack itself, but there are a few others recommended gem dependancies:
- unicorn: fast rack-compatible server that can be used for production.
- simplecov: a simple way to generate statistics about your unit tests coverage.


## How to

Install the RackStep gem:

gem install rackstep

To create a new application, clone this repository and use the example available at the app-template folder as a starting point.

Run the application using any rack-compatible server. For development I recommend using shotgun or rackup. For production, RackStep is pre-configured to use unicorn.


## TODOs (some of them)

- use RDoc or YARD for documentation.
- create more unit tests.
- add some performance tests and do some optimizations.
- solve all the TODOs listed around the source code.


## Author

RackStep is developed by Marcio Frayze David - mfdavid@gmail.com.
