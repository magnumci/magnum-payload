require "bundler"
require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = false
end

task :console do
  require "irb"
  require "irb/completion"
  require "magnum/payload"
  
  ARGV.clear
  IRB.start
end

task :default => :test