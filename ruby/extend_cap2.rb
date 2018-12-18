require "cap2"

module Cap2
	class Process
		def ldisable(*capabilities)
			capabilities.map { |cap| self.disable cap }
		end

		def disable!
			ldisable @caps[:effective]
		end

		private
		# Raises a RuntimeError if the process's pid is not the same as the current
		# pid (you cannot enable capabilities for other processes, that's their job).
		def check_pid
			unless @pid == ::Process.pid
				puts 'Cannot modify capabilities of other processes'
			end
		end
	end
end
