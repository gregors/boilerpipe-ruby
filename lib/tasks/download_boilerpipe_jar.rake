desc 'Downloads forked boilerpipe jar from Gregors github for sanity checks'
task :download_boilerpipe_jar do
  FileUtils.mkdir_p 'spec/sanity_checks/jars/'
  Dir.chdir 'spec/sanity_checks/jars/'
 `wget 'https://github.com/gregors/jruby-boilerpipe/raw/master/lib/boilerpipe-common-2.0-SNAPSHOT-jar-with-dependencies.jar'`
end
