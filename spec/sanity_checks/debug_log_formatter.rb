#!/usr/bin/env ruby

ARGF.each_line do |line|
  begin
    output_line = line.gsub('boilerplate', 'BOILERPLATE') .gsub('de.l3s.boilerpipe/', '')
    $stdout.puts output_line
  rescue Errno::EPIPE
    exit(74)
  end
end
