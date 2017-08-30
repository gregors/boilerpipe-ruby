def jruby?
  RUBY_PLATFORM == "java"
end

if jruby?
  require_relative 'jruby_db'
else
  require_relative 'db'
end

require 'boilerpipe'
require 'rickshaw'

TokenizerTest.all.each do |t|
  begin
    output = Boilerpipe::UnicodeTokenizer.tokenize(t.input)
    output = output.to_a if RUBY_PLATFORM == "java"
    output = output.to_a.join(' ')

    if output.to_sha1 == t.output.to_sha1
      print '.'
    else
      puts "doesnt match - error id: #{t.id}"
    end
  rescue
    puts "kaboom - error id: #{t.id}"
  end
end



