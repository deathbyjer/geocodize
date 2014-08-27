class Geocodize::Lookups::Base

  PER_SECOND = 1
  
  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
  
  def self.if_open_then_use
    true
  end
  
  def self.get_per_second
    PER_SECOND
  end
  
  def self.lookup_address(address)
    {lat: nil, lon: nil}
  end
  
  def self.lookup_postal(postal)
    {lat: nil, lon: nil}
  end
  
end