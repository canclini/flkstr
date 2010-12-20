class CompaniesController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :exists, :join]
  layout 'small_footer', :only => [:tags]
  
  def index
    @companies = Company.search(params[:query]).paginate :per_page => 10, :page => params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def tags
    # only for initial signup during website phase
    @company = Company.find(params[:id])
  end

  def autocomplete
    query = params[:term]
    @items = Company.where("name like ?","%#{query}%")    
    respond_to do |format|
      format.json { render :json => @items.to_json }
    end
  end
  
  def exists
    @companies = Company.search(params[:search]).limit(10)
    respond_to do |format|
      format.js
    end
  end
  
  def join
    @company = Company.find(params[:id])
    if @company.users.empty?
      @takeorjoin = "takeover"
    else
      @takeorjoin = "join"
    end
    respond_to do |format|
      format.js
    end
  end
  
  def show
    @company = Company.find(params[:id])
  end
  
  def edit
    @company = current_company
  end
  
  def update
    @company = current_company
    if @company.update_attributes(params[:company])  
      flash[:notice] = "Successfully updated company profile."  
      redirect_to @company
    else  
      render :action => 'edit'  
    end
  end
end
