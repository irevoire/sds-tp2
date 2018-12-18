require 'socket'

require_relative "cap2/cap2"

if Process.uid != 0
	puts "Script need to be run as root"
	exit 
end

puts "\e[31;1mCapabilities before dropping them:\e[m\n"
p Cap2.process

Cap2.process.disable! [:net_bind_service, :setgid, :setuid]

puts "\e[31;1mCapabilities after dropping them:\e[m\n"
p Cap2.process

#Process::Sys.setegid 65534 # nobody
#Process::Sys.seteuid 65534 # nobody

puts "\e[31;1mCapabilities after dropping them:\e[m\n"
p Cap2.process

server = TCPServer.new 84
loop do
	client = server.accept
	p :got_someone
	client.puts "Hello !"
	client.puts "Time is #{Time.now}"
	client.close
end

