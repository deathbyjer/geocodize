require 'spec_helper'

describe "Geocodize::Queue" do
  before(:each) do
    @redis = Geocodize::Queue.redis
    @queue_name = Geocodize::Queue.queue_name 
  end
  
  after(:each) do
    Geocodize::Queue.redis = @redis
    Geocodize::Queue.queue_name = @queue_name
    Geocodize::Queue.clear
  end
  
  it "initialized properly" do
    expect(Geocodize::Queue).to respond_to(:redis).and respond_to(:queue_name)
    expect(Geocodize::Queue.redis).to be_truthy    
    expect(Geocodize::Queue.queue_name).to be_truthy    
  end
  
  it "accepts initialization changes" do
    Geocodize::Queue.initialize!({redis: { host: "localhost", port: 6379}, queue: "custom_name" })
    expect(Geocodize::Queue).to respond_to(:redis).and respond_to(:queue_name)
    expect(Geocodize::Queue.redis).to be_truthy
    expect(Geocodize::Queue.redis.client.host).to be_truthy.and eq("localhost")
    expect(Geocodize::Queue.redis.client.port).to be_truthy.and eq(6379)
    expect(Geocodize::Queue.queue_name).to be_truthy.and eq("custom_name")
  end
  
  it "counts" do
    expect(Geocodize::Queue).to respond_to(:count)
    expect(Geocodize::Queue.count).to be_kind_of(Fixnum)
  end
  
  it "clears properly" do
    Geocodize::Queue.enqueue "add1", "", {}
    Geocodize::Queue.enqueue "add2", "", {}
    Geocodize::Queue.clear
    expect(Geocodize::Queue.count).to eq(0)
  end
  
  it "adds properly to the redis queue" do
    Geocodize::Queue.enqueue "add1", "", {}
    expect(Geocodize::Queue.count).to eq(1)
  end
  
  it "removes properly from the redis queue" do
    Geocodize::Queue.enqueue "add1", "object1", {option: "option1"}
    expect(Geocodize::Queue.count).to eq(1)
    item = Geocodize::Queue.dequeue
    expect(Geocodize::Queue.count).to eq(0)
    expect(item[0]).to eq("add1")
    expect(item[1]).to eq("object1")
    expect(item[2]).to be_kind_of(Hash)
    expect(item[2]["option"]).to eq("option1")
  end
end