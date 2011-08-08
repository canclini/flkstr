class CompaniesController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create, :exists, :join]
  
  def new
    @company = Company.new  
    @user = @company.users.new    
    render :layout => 'small_footer'
  end
  
  def create
    # hack for terms of service
    params[:company][:terms_of_service] = params[:user][:terms_of_service]
    @company = Company.new(params[:company][:company])
    @user = User.new(params[:company])
    
    if @company.valid? && @user.valid?
      @company.save
      @user.save
      @company.plan = Plan.find_by_name('ready')    
      @company.users << @user

      flash[:notice] = "Erfolgreich registiert"
      #UserMailer.registration_confirmation(resource).deliver
      cookies.permanent[:auth_token] = @user.auth_token
      
      redirect_to dashboard_url
        
    else
      render :new, :layout => 'small_footer'
    end
    
  end
  
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
    @tag_list = @company.tag_list
    render :layout => 'small_footer'
  end
  
  def add_tag
    # add to input list (tags_company)
    @company = Company.find(params[:id])
    tag = params[:tags][:tag]
    @company.tag_list.add(tag)
    @company.save
    @tag_list = @company.tag_list
    respond_to do |format|
      format.js { render 'tags/update_tag_list' }
      format.html { render :tags }
    end
  end
  
  def remove_tag
    # remove from input list (tags_company)
    @company = Company.find(params[:id])
    tag = params[:tag]
    @company.tag_list.remove(tag)
    @company.save
    @tag_list = @company.tag_list
    respond_to do |format|
      format.js { render 'tags/update_tag_list' }
      format.html { render :tags }
    end
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
    unless @company ==  Company.find(params[:id])
      flash[:error] = "Unerlaubte Aktion"
      redirect_to dashboard_url
    end
  end
  
  def update
    @company = current_company
    if @company.update_attributes(params[:company])  
      flash[:notice] = "Profil wurde aktualisiert"
      redirect_to @company
    else  
      render :action => 'edit'
    end
  end
  
end
