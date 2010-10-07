class CompaniesController < ApplicationController
  layout 'website', :only => [:new]

  before_filter :authenticate_user!, :except => [:new, :create, :exists, :join]
  before_filter :no_user!, :only => [:new, :create]
  
  def index
    @companies = Company.search(params[:search]).paginate :per_page => 10, :page => params[:page]
    respond_to do |format|
      format.html
      format.js
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

  def new
    @company = Company.new
    @companies = []
  end
  
  def create
#    @company = Company.new(params[:company])
#    if @company.save    
#      flash[:notice] = "Die Firma wurde erstellt."
#      redirect_to register_path(:company => @company)
#    else
#      @companies = Company.search(@company.name).limit(10)
#      render :action => 'new'
#    end
    
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
