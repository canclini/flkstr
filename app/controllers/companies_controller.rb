class CompaniesController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :show]
  
  def index
    @companies = Company.search(params[:search]).paginate :per_page => 10, :page => params[:page]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
#    redirect_to signup_path unless Plan::NAMES.include? params[:plan]
    @company = Company.new
#    @plan = Plan.find_by_name(params[:plan])
  end

  def update
  end

end
