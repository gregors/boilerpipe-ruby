require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


desc 'Downloads forked boilerpipe jar from Gregors github for sanity checks'
task :download_boilerpipe_jar do
  Dir.chdir 'spec/sanity_checks/jars/'
 `wget 'https://github.com/gregors/jruby-boilerpipe/raw/master/lib/boilerpipe-common-2.0-SNAPSHOT-jar-with-dependencies.jar'`
end
