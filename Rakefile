require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test

load File.dirname(__FILE__) + "/tasks/pull-json.rake"