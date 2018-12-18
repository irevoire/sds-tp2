#!/usr/bin/env ruby
require_relative "cap2/cap2"

if ARGV.size == 0
	puts "Give me a command"
	exit 
end

if Process.uid != 0
	puts "Script need to be run as root"
	exit 
end

pid = spawn(ARGV.join(" "))

process = Cap2.process pid

puts "\e[31;1mCapabilities before dropping them:\e[m\n"

p process

#Process::Sys.setegid 65534 # nobody
#Process::Sys.seteuid 65534 # nobody

process.disable!

puts "\e[31;1mCapabilities after dropping them:\e[m\n"
p process

p Cap2.process

require 'socket'
server = TCPServer.new 84
loop do
	client = server.accept
	p :got_someone
	client.puts "Hello !"
	client.puts "Time is #{Time.now}"
	client.close
end

