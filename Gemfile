source 'https://rubygems.org'
ruby "2.2.1"

# Used for unit testing execution.
gem 'rake'
group :test do
  gem 'minitest'
end

# All this gems are optional, but highly recommended.
gem 'unicorn'   # Fast rack-compatible server that can be used for production.
gem 'sanitize'  # Very good and simple lib to sanitize any parameters passed from the user, to avoid sql injection, etc.
gem 'tux'       # Nice utility similar to IRB, but that loads all your classes. Just run "tux" (after installing the gem) in your root directory.
gem 'simplecov', :require => false, :group => :test   # A simple way to generate statistics about you unit tests coverage.
