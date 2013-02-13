require 'rake'
require 'rubygems'

require 'rspec/core/rake_task'
require 'puppet-lint/tasks/puppet-lint'
#require 'puppetlabs_spec_helper/rake_tasks'
require 'puppetlabs_spec_helper/module_spec_helper'


RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end
#task :default => [:spec, :lint]
task :default => [:spec]
