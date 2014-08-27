require_relative "base"

class Geocodize::Lookups::OSM < Geocodize::Lookups::Base
  require 'net/http'
  require 'json'
  
  SEARCH_URL = "http://nominatim.openstreetmap.org/search?";
  EMPTY_PAARAMS = -999
  HTTP_ERROR = -1
  JSON_ERROR = -2
  NO_DATA = -3
  
  PER_SECOND = 1
  
  @last_queried = 0
  
  def self.if_open_then_use
    return false if Time.now.to_f + (1.0 / PER_SECOND) < @last_queried
    @last_queried = Time.now.to_f
    true
  end
  
  def self.lookup_address(address)
    data = contact_osm({q: address})
    return data unless analyze_response(data)
    { lat: data["lat"], lon: data["lon"] }
  end
  
  def self.lookup_postal(postal)
    data = contact_osm({postalcode: postal})
    return data unless analyze_response(data)
    { lat: data["lat"], lon: data["lon"] }
  end
  
  private 
  def self.contact_osm(params)
    return EMPTY_PARAMS if params.empty?
    
    params[:format] = "json"
    uri = URI(SEARCH_URL)
    uri.query = URI.encode_www_form(params)
    
    begin
      res = Net::HTTP.get_response(uri)
      data = JSON.parse(res.body)
      data.empty? ? NO_DATA : data.first
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError,
       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
      HTTP_ERROR
    rescue JSON::JSONError
      JSON_ERROR      
    end
  end
  
  def self.analyze_response(data) 
    case data
    when EMPTY_PAARAMS
      false
    when HTTP_ERROR
      false
    when JSON_ERROR
      false
    when NO_DATA
      false
    else
      true
    end
  end
end