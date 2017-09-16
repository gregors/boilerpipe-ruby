#!/usr/bin/env ruby

ARGF.each_line do |line|
  begin
    next if line =~ /^\[/
    $stdout.puts line
  rescue Errno::EPIPE
    exit(74)
  end
end
