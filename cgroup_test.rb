require_relative "cgm/cgm.rb"

cpu = Cgm.new "climit", ["cpu"]

cpu.limit_cpu_share 10

cpu.exec "stress -c 4"
