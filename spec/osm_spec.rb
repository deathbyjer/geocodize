require 'spec_helper'

describe "Geocodize::Lookups::OSM" do

  it "postal returns a lat|lon" do
    postal = Geocodize::Lookups::OSM.lookup_postal 10001
    expect(postal).to have_key(:lat).and have_key(:lon)
  end
  
  it "city returns a lat|lon" do
    addr = Geocodize::Lookups::OSM.lookup_address "New York, NY"
    expect(addr).to have_key(:lat).and have_key(:lon)
  end
  
end