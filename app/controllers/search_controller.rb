# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  before_filter :authenticate_user!, :except => [:public]
  def index
    @active = :first
  end
  
  def create
    @companies = Kaminari.paginate_array(Company.search(params[:query])).page(params[:page])
    @requests = Kaminari.paginate_array(Request.search(params[:query])).page(params[:page])

    render :action => 'index'
  end
  
  # search action for searches initiated from the wewbsite
  def public

  end

end
