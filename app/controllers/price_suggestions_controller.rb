class PriceSuggestionsController < ApplicationController
  
  def create
    @price = PriceSuggestion.new(params[:price_suggestion])
    @price.save
    flash[:notice] = "Besten Dank"
    redirect_to plans_path()
  end
  
end
