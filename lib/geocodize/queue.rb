class Geocodize::Queue
  
  require "redis"
  class << self
    attr_accessor :redis
    attr_accessor :queue_name
  end
  
  def self.initialize!(options = {})
    options = options || {}
    self.redis = options[:redis] ? Redis.new(options[:redis]) : Redis.new
    self.queue_name = options[:queue] || "geocodize:queue:[]"
  end

  def self.enqueue(address, klass_name, options = {})
    redis.zadd queue_name, Time.now.to_i, [ address, klass_name, options ].to_json
  end
  
  def self.dequeue
    out = false
    redis.multi do |r|
      out = r.zrange queue_name, 0, 1
      r.zremrangebyrank queue_name, 0, 1
    end
    return nil if out.value.nil? || out.value.empty?
    begin
      return JSON.parse(out.value.first)
    rescue
    end
    nil
  end
  
  def self.count
    redis.zcard queue_name
  end
  
  def self.clear
    redis.del queue_name
  end
end