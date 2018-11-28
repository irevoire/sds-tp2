require 'socket'

require_relative "extend_cap2"

if Process.uid != 0
	puts "Script need to be run as root"
	exit 
end

puts "\e[31;1mCapabilities before dropping them:\e[m\n"
p Cap2.process

Process::Sys.setegid 65534 # nobody
Process::Sys.seteuid 65534 # nobody

Cap2.process.disable!

puts "\e[31;1mCapabilities after dropping them:\e[m\n"
p Cap2.process

sleep 1

exec("bash")

loop do; end
