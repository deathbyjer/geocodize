module Geocodize::Lookups
  def self.load!
    Dir[File.dirname(__FILE__) + "/lookups/*.rb"].each do |file| 
      require file
    end
    
    @childrens = ::Geocodize::Lookups::Base.descendants
  end
  
  def self.is_postal(address)
    address.to_s.match(/^\d{5}$/)
  end
  
  def self.lookup(address)
    Geocodize::Cache.get_cache.fetch address do
      addr = nil
      @childrens.each do |klass|
        if klass.if_open_then_use
          addr = is_postal(address) ? klass.lookup_postal(address) : klass.lookup_address(address)
          break
        end
      end
      
      addr.is_a?(Hash) ? addr : nil
    end
  end
end

module Geocodize
  def self.lookup(address)
    Geocodize::Lookups.lookup address
  end
end