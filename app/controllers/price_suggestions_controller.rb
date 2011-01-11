class PriceSuggestionsController < ApplicationController
  
  def create
    @price = PriceSuggestion.new(params[:price_suggestion])
    @price.save
    respond_to do |format|
      format.html { 
          flash[:notice] = "Besten Dank f&uuml;r Ihre Meinung!"
          redirect_to plans_path()
       }
      format.js
    end
    
  end
  
end
