# You may configure here rake tasks.
# By default, one task is configured to run all the unit tests. To execute it,
# run: "rake test".

require 'rack'
require 'rake/testtask'
require 'rackstep'

# Creating a task for running all the unit tests declared at app/tests.
Rake::TestTask.new do |task|
  task.libs << './app/test/lib'
  task.test_files = FileList['app/test/test*.rb']
  task.verbose = true
end
