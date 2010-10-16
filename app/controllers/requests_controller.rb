class RequestsController < ApplicationController

  def index
    params[:status] ||= "open"
    @requests = current_company.requests.where("status = ?", params[:status]).paginate :per_page => 5, :page => params[:page], :order => 'created_at ASC'
    @active = params[:status]
  end

  def show
    @request = Request.find(params[:id])
    @company = @request.company
    @active = @request.status
  end

  def new
    @company = current_company
    redirect_to settings_path unless @company.add_request?
    @request = current_company.requests.new(:company => @company)
    @active = :create
  end

  def create
    @company = current_company
    redirect_to signup_path unless @company.add_request? 
    @request = Request.new(params[:request])
    if @request.save
      Delayed::Job.enqueue(MatchJob.new(@request.id))
      flash[:notice] = "Der Auftrag wurde erfasst. Wir suchen nach geeigneten Lieferanten"
      redirect_to request_path(@request)
    else
      @active = :create
      render :action => 'new'
    end
  end
  
  def edit
  end

end
