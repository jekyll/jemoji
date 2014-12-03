require 'rubygems'
require 'bundler/gem_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:test) do |t|
    t.rspec_opts = "--color --require spec_helper"
  end
rescue LoadError
end
