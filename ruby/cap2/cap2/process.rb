module Cap2
	# A class with methods for managing capabilities for the
	# process with pid provided to the initialize method.
	class Process
		# Initialize a new Process object for the given pid.
		def initialize(pid)
			@pid  = pid
			@caps = getcaps
		end

		def ldisable(capabilities)
			capabilities.map { |cap| self.disable cap }
		end

		def disable!(except = [])
			ldisable @caps[:permitted].select { |cap| !(except.include? cap) }
			ldisable @caps[:effective].select { |cap| !(except.include? cap) }
			ldisable @caps[:inheritable].select { |cap| !(except.include? cap) }
		end

		# Returns whether the given capabilities are permitted
		def permitted?(*capabilities)
			reload
			@caps[:permitted].superset? Set[*capabilities]
		end

		# Returns whether the given capabilities are enabled
		def enabled?(*capabilities)
			reload
			@caps[:effective].superset? Set[*capabilities]
		end

		# Returns whether the given capabilities are inheritable
		def inheritable?(capabilities)
			reload
			@caps[:inheritable].superset? Set[*capabilities]
		end

		# Enable the given capability for this process.
		def enable(capability)
			check_pid
			@caps[:effective].add(capability)
			@caps[:permitted].add(capability)
			@caps[:inheritable].add(capability)
			save
		end

		# Disable the given capability for this process.
		def disable(capability)
			check_pid
			@caps[:effective].delete(capability)
			@caps[:permitted].delete(capability)
			@caps[:inheritable].delete(capability)
			save
		end

		private
		# Raises a RuntimeError if the process's pid is not the same as the current
		# pid (you cannot enable capabilities for other processes, that's their job).
		def check_pid
			unless @pid == ::Process.pid
				puts 'Cannot modify capabilities of other processes'
			end
		end

		def reload
			@caps = getcaps
		end
	end
end
