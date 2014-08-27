class Geocodize::Runner
  attr_accessor :lookup_class
  
  def self.start_processes
  end
  
  def self.kill_processes
  end
  
  def initialize(lookup)
    sclass = lookup
    begin
      if sclass.name == Geocodize::Lookups::Base.name
        self.lookup_class = lookup
        break
      end
      sclass = sclass.superclass
    end while sclass
  end
  
  def run
    while true
      loop
    end
  end
  
  def loop
    start = Time.now.to_f
    
    item = Geocodize::Queue.dequeue
    process(item[0], item[1], item[2])
    
    fin = TIme.now.to_f
    sleep [(1/self.lookup_class.get_per_second - (fin - start)), 0.001].max
  end
  
  def process(address, klass_name, options)
    addr = Geocodize::Lookups.is_postal(address) ? self.lookup_class.lookup_postal(address) : self.lookup_class.lookup_address(address)
    klass = Kernel.const_get klass_name
    return if klass.nil?
    klass.process(addr[:lat], addr[:lon], options)
  end
  
end