class RequestsController < ApplicationController

  def index
    params[:status] ||= "open"
    @requests = current_company.requests.where("status = ?", params[:status]).order("created_at").page(params[:page])
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
    @request = current_company.requests.new(:company => @company, :duedate => (Time.now + 1.month))
    @active = :create
  end

  def create
    @company = current_company
    redirect_to signup_path unless @company.add_request? 
    if params[:commit] == 'speichern'
      params[:request][:status] = 'draft'
    end
    params[:request][:tag_list] = params[:request][:tag_list].join(",") unless params[:request][:tag_list].nil?
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
    @company = current_company
    @request = current_company.requests.find(params[:id])
    @request.duedate ||= Time.now + 1.month
    @active = @request.status
  end
  
  def update
    @request = Request.find(params[:id])

    if params[:commit] == 'speichern'
      params[:request][:status] = 'draft'
    else
      params[:request][:status] = 'open'
    end
    
    if @request.update_attributes(params[:request])  
      flash[:notice] = "Request wurde aktualisiert"
      redirect_to @request
    else  
      render :action => 'edit'
    end    
  end
  
  def destroy
    @request = current_company.requests.find(params[:id])
    @request.destroy
    flash[:notice] = "Der Auftrag wurde geloescht."
    redirect_to requests_filter_path(:status => "draft")    
  end
  
  def confirm_archive
    
  end

  def discard
    flash[:notice] = "Der Auftrag wurde verworfen"
    redirect_to requests_path()
  end
  
  def assign
    request = Request.find(params[:id])
    request.update_attributes(:status => "assigned")
    redirect_to request
  end

  def recall
    request = Request.find(params[:id])
    request.update_attributes(:status => "recalled")
    redirect_to request
  end

  def archive
    Request.find(params[:request_ids]).each do |request|
      request.archive
    end
    #Request.update_all(["archived_at=?", Time.now], :id => params[:requests_ids])
    redirect_to requests_path
  end
end
