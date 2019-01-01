require_relative './jars/boilerpipe-common-2.0-SNAPSHOT-jar-with-dependencies.jar'

java_import 'com.kohlschutter.boilerpipe.document.TextBlock'
java_import 'com.kohlschutter.boilerpipe.document.TextDocument'

@text_blocks = [TextBlock.new('one'), TextBlock.new('two')]

@text_blocks.each do |tb|
  puts tb
end
puts 'done'
