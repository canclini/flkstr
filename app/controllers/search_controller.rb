class SearchController < ApplicationController
  before_filter :authenticate_user!, :except => [:public]
  def index
    @active = :first
  end
  
  def create
    @companies = Company.search(params[:query]).paginate :per_page => 10, :page => params[:page]
    @requests = Request.search(params[:query]).paginate :per_page => 10, :page => params[:page]

    render :action => 'index'
  end
  
  # search action for searches initiated from the wewbsite
  def public

  end

end
