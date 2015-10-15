# You may configure here rake tasks.
# By default, one task is configured to run all the unit tests. To execute it, run: "rake test".

require 'rake/testtask'

# Loading App
require './app/main'

# Creating a task for running all the unit tests declared at app/tests.
Rake::TestTask.new do |task|
  task.pattern = "app/tests/*.rb"
end

