require_relative "geocodize/version"
require_relative "geocodize/lookup"
require_relative "geocodize/cache"
require_relative "geocodize/queue"
require_relative "geocodize/runner"

module Geocodize

  def self.initialize!(options = {})
    Geocodize::Lookups.load!
    Geocodize::Cache.initialize!(options[:cache])
    Geocodize::Queue.initialize!(options[:queue])
  end
end
