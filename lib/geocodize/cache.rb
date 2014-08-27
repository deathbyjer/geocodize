class Geocodize::Cache
  def self.initialize!(options = {})
    childrens = ObjectSpace.each_object(Class).select { |k| k < self }
    case childrens.size
    when 0
      @singleton = Geocodize::Cache.new options
    when 1
      @singleton = childrens.first.new options
    else
      klass = childrens.select{|k| k.name == options[:cache_class]}.first
      @singleton = klass.nil? ? childrens.first.new(options) : klass.new(options)
    end
  end
  
  def initialize(options = {})
  end
  
  def self.get_cache
    @singleton
  end
  
  def fetch(key)
    yield
  end
  
  def cache(key)
    yield
  end
end