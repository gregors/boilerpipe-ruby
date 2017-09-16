require "bundler/gem_tasks"

Dir['lib/tasks/**/*.rake'].each { |f| load f }

task :default => []
Rake::Task[:default].clear_prerequisites

task :default => [
  :spec,
]
