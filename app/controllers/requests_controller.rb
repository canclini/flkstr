class RequestsController < ApplicationController

  def index
    #params[:filter] ||= "all"
    @requests = current_company.requests.paginate :per_page => 5, :page => params[:page], :order => 'created_at ASC'
  end

  def show
    @request = Request.find(params[:id])
    @company = @request.company
  end

  def new
    @company = current_company
    redirect_to settings_path unless @company.add_request?
    @request = current_company.requests.new(:company => @company)
  end

  def create
    @company = current_company
    redirect_to signup_path unless @company.add_request? 
    @request = Request.new(params[:request])
    if @request.save
#      Match.initiate(@request)
      flash[:notice] = "Der Auftrag wurde erfasst"
      redirect_to request_path(@request)
    else
      render :action => 'new'
    end
  end
  
  def edit
  end

end
