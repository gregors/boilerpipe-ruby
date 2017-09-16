desc 'Start a console with Boilerpipe loaded'
task :console do
  system 'bundle exec irb -Ilib -r./lib/boilerpipe'
end
