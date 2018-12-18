#!/usr/bin/env ruby
require_relative "extend_cap2"

if ARGV.size == 0
	puts "Give me a command"
	exit 
end

if Process.uid != 0
	puts "Script need to be run as root"
	exit 
end

pid = fork do
	exec(ARGV.join(" "))
end

process = Cap2.process pid

puts "\e[31;1mCapabilities before dropping them:\e[m\n"
p process

#Process::Sys.setegid 65534 # nobody
#Process::Sys.seteuid 65534 # nobody

sleep 2

process.disable!

puts "\e[31;1mCapabilities after dropping them:\e[m\n"
p Cap2.process

loop do; end
