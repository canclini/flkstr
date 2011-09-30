class TagsController < ApplicationController
  
  def autocomplete
    query = params[:term]
    @tags = Tag.where("name like ?","%#{query}%")    
    respond_to do |format|
      format.json { render :json => @tags.all.to_json }      
    end
  end
  
end
