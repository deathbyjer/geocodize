require 'spec_helper'

class ProvidedClassTest
  def self.process(lat, lon, options)
  
  end
end

class ProvidedOptionsTest
  def self.process(lat, lon, options)
  
  end
end

class LoopFunctionTest
  class << self
    attr_accessor :test_response
  end
  
  def self.process(lat, lon, options)
  
  end
end

describe "Geocodize::Runner" do

  it "initializes properly" do
    test_runner = Geocodize::Runner.new(Geocodize::Lookups::Base)
  end
  
  it "requires a Lookup Base" do
  end
  
  it "uses the provided class" do
  
  end
  
  it "uses the provided options" do
  
  end
  
  it "loop functions properly" do
  
  end

end