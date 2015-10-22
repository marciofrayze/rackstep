# Configuring task to run all the unit tests.
# To execute it: "rake test",

require 'rack'
require 'rake/testtask'

# Creating a task for running all the unit tests declared at app/tests.
Rake::TestTask.new do |task|
  task.libs << './test/util'
  task.test_files = FileList['test/test*.rb']
  task.verbose = true
end
