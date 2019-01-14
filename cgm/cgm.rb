SUBSYSTEMS = [
	"cpuset",
	"cpu", 
	"cpuacct",
	"memory",
	"devices",
	"freezer",
	"net_cls",
	"blkio"
]

class Cgm
	attr_accessor :name, :subsystems
	def initialize name, subsystems
		self.name = name
		self.subsystems = subsystems
		subsystems.each { |system|
			if !(SUBSYSTEMS.include? system)
				raise system.to_s + "does not exist"
			end
		}
		`sudo cgcreate -g #{subsystems.join ","}:/#{name}`
	end

	def limit_cpu_share limit
		raise "you need to include the cpu subsystem" if !(subsystems.include? "cpu")
		`sudo cgset -r cpu.shares=#{limit} #{name}`
	end

	def limit_cpu_percentage limit
		raise "you need to include the cpu subsystem" if !(subsystems.include? "cpu")
		`sudo cgset -r cpu.cfs_quota_us=25000,cpu.cfs_period_us=100000 #{name}`
	end

	def limit_memory limit
		raise "you need to include the memory subsystem" if !(subsystems.include? "memory")
		`sudo cgset -r memory.limit_in_bytes=#{limit} #{name}`
	end

	def clean
		`sudo cgdelete #{subsystems.join ","}:#{name}`
	end

	def apply
		pid = Process.pid
		`sudo cgclassify -g #{subsystems.join ","}:#{name} #{pid}`
	end

	def exec cmd
		command = "sudo cgexec -g #{subsystems.join ","}:#{name} #{cmd}"
		puts command
		system(command)
	end
end
