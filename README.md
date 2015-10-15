# RackStep

RackStep is (yet another) micro ruby framework for web development.

Main goals are:
- be dead simple.
- keep the source small.
- implement only the necessary; no overcomplication.

If you like ruby frameworks like Sinatra, you may like RackStep.


## Why yet another framework?

Two main reasons:
- I like the principle behind Sinatra, but I dislike the way it is implemented,
so I decided to create an alternative to use it on my side projects.
- I wanted to learn more about how Rack works.


## Dependancies

RackStep is developed and tested with Ruby 2.2.1. The only hard dependency is
Rack itself, but there are a few others recommended gem dependancies:
- unicorn: fast rack-compatible server that can be used for production.
- sanitize: very good and simple lib to sanitize any parameters passed from the user, to avoid sql injection, etc.
- tux: nice utility similar to IRB, but that loads all your classes. Just run "tux" (after installing the gem) in your root directory.
- simplecov: a simple way to generate statistics about you unit tests coverage.


## How to

RackStep is not (at least yet) a gem. To create a new application, clone this
repository
https://github.com/mfdavid/RackStep.git


## Author

RackStep is developed by Marcio Frayze David - mfdavid@gmail.com.
