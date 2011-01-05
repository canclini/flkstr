class PlansController < ApplicationController
  layout 'website'
  
  def index
    @price_scale = PriceSuggestion.new(:plan => "scale")
    @price_connect = PriceSuggestion.new(:plan => "connect")
  end
end
