require "cap2"

module Cap2
	class Process
		def ldisable(*capabilities)
			capabilities.map { |cap| self.disable cap }
		end

		def disable!
			ldisable @caps[:effective]
		end
	end
end
