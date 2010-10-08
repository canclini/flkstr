class LeadsController < ApplicationController
  def index
    @company = current_company
    @leads = current_company.leads.new_or_accepted
    respond_to do |format|
      format.html
      format.js
    end
    
  end

  def show
    @company = current_company
    @lead = @company.leads.find(params[:id])    
    @request = @lead.request
  end

  def decline
    @lead = current_company.leads.find(params[:id])
    if @lead.update_attributes(:status => 'declined')  
      flash[:notice] = "Der Lead wurde abgelehnt"  
      redirect_to leads_path
    else  
      flash[:notice] = "Uups.. da ging was schief."  
      redirect_to @lead
    end
  end
  
  def accept
    @lead = current_company.leads.find(params[:id])
    if @lead.update_attributes(:status => 'accepted')  
      flash[:notice] = "Lead angenommen! Viel Erfolg beim offerieren!"  
      redirect_to @lead
    else  
      flash[:notice] = "Uups.. da ging was schief."  
      redirect_to @lead
    end
  end

end
