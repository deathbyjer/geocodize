require "spec_helper"

describe "Geocodize::Lookup" do

  it "city should have lat|lon" do
    city = Geocodize.lookup "New York, NY"
    expect(city).to have_key(:lat).and have_key(:lon)
  end
  
  it "lookup postal code" do
    postal = Geocodize.lookup "10025"
    expect(postal).to have_key(:lat).and have_key(:lon)
  end

end