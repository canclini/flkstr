class CompaniesController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]
  before_filter :no_user!, :only => [:new, :create]
  
  def index
    @companies = Company.search(params[:search]).paginate :per_page => 10, :page => params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    redirect_to signup_path unless Plan::NAMES.include? params[:plan]
    @company = Company.new
    @plan = Plan.find_by_name(params[:plan])
  end
  
  def create
    @plan = Plan.find_by_name(params[:plan][:name])

    @company = Company.new(params[:company])
    @company.addresses.build(:main => true)
    if @company.save    
      flash[:notice] = "Die Firma wurde erstellt."
      redirect_to register_path(:plan => @plan.name, :company => @company)
    else
      render :action => 'new'
    end
    
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
