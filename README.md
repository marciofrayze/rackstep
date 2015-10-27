# RackStep

RackStep is (yet another) micro ruby framework for microservices and web development.

Main goals are:
- be as simple as possible.
- keep the source code small.
- implement only the necessary; no overcomplication.
- allow easy implementation of microservices and single-page application (SPA).


## Status
[![Gem Version](https://badge.fury.io/rb/rackstep.svg)](https://badge.fury.io/rb/rackstep)
[![Travis CI](https://api.travis-ci.org/mfdavid/rackstep.svg)](ttps://travis-ci.org/mfdavid/rackstep)
[![Code Climate](https://codeclimate.com/github/mfdavid/rackstep/badges/gpa.svg)](https://codeclimate.com/github/mfdavid/rackstep)
[![Ich CI](http://inch-ci.org/github/mfdavid/rackstep.png)](http://inch-ci.org/github/mfdavid/rackstep)

[Travis-CI - Tests execution log](https://travis-ci.org/mfdavid/rackstep)

[Code Climate - Code review analysis](https://codeclimate.com/github/mfdavid/rackstep)

[Inch-CI - Documentation coverage analysis](http://inch-ci.org/github/mfdavid/rackstep)


## Dependancies

RackStep is developed and tested with Ruby 2.2.3. The only hard dependency is
Rack itself, but there are a few others recommended gem dependancies:
- unicorn: fast rack-compatible server that can be used for production.
- simplecov: a simple way to generate statistics about your unit tests coverage.


## How to

Install the RackStep gem:

gem install rackstep

To create a new application, you may clone one of the following repositories as a starting point example:

A full app example:
https://github.com/mfdavid/rackstep-app-template

A minimum app example:
https://github.com/mfdavid/rackstep-minimum-app-template

Run the application using any rack-compatible server. For development I recommend using shotgun or rackup. For production, RackStep full app example is pre-configured to use unicorn.


## TODOs (some of them)

- use RDoc or YARD for documentation.
- create more tests.
- add some performance tests and do some optimizations.
- solve all the TODOs listed around the source code.


## Author

RackStep is developed by Marcio Frayze David - mfdavid@gmail.com.
