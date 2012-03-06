# -*- encoding : utf-8 -*-
class Address < ActiveRecord::Base
  acts_as_mappable

  belongs_to :company
  before_save :calc_coordinates

  scope :main, where("main = ?", true)
  scope :secondaries, where("type = ?", false)

  def geo
    # gets the geo object which includes the latitude and langitude values
    #used to save with the object
    #Geokit::Geocoders::GoogleGeocoder.geocode full_address
    Geokit::Geocoders::YahooGeocoder.geocode full_address
  end

  def map(mark_text="here")
    # creates the Google map object for this address object
    # the parameter mark_text is displayed on the map when clicking
    # on the mark
    map = GoogleMap::Map.new
    map.center = GoogleMap::Point.new(lat, lng)
    map.zoom = 13 
    map.markers << GoogleMap::Marker.new(  :map => map, :lat => lat, :lng => lng, :html => mark_text)
    map
  end

  def full_address
    # concats to string for the geo method
    # Example: "Katharina Sulzer Platz 2, Winterthur Switzerland "
    street.to_s + ", " + city.to_s + " " + country.to_s
  end


# PRIVATE METHODS  
  private

  def calc_coordinates
    # called via before_save filter. Anytime a new address is created or
    # an existing address is updated we generate the new coordinats to
    # save them togehter with the object to save time showing the google map.
    self.lng = geo.lng ||= 0
    self.lat = geo.lat ||= 0
  end

end
