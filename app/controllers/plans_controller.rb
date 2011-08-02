class PlansController < ApplicationController
  skip_before_filter :force_subdomain
  layout 'website'
  
  def index
    @price_scale = PriceSuggestion.new(:plan => "scale")
    @price_connect = PriceSuggestion.new(:plan => "connect")
  end
end
