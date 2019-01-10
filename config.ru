require "roda"

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
Cap2.process.enable :net_bind_service

class App < Roda
	route do |r|
		r.root do
			"Hello World!"
		end
		r.on "cap" do
			response["content-type"] = "text/plain"
			Cap2.process.inspect
		end
	end
end

run App.freeze.app
