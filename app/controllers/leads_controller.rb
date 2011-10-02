class LeadsController < ApplicationController
  def index
    params[:status] ||= "new"
    @company = current_company
    @leads = current_company.leads.where("status = ?", params[:status]).order("created_at").page(params[:page])
    @active = params[:status]
  end
  
  def actionbox
    @company = current_company
    @leads = current_company.leads.new_or_accepted
  end

  def show
    @company = current_company
    @lead = @company.leads.find(params[:id])    
    @request = @lead.request
    @active = @lead.status
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
  
  def won
    @lead = current_company.leads.find(params[:id])
    if @lead.update_attributes(:status => 'won')  
      flash[:notice] = "Gratulation zum gewonnenen Auftrag!"  
      redirect_to leads_path()
    else  
      flash[:notice] = "Uups.. da ging was schief."  
      redirect_to @lead
    end    
  end

  def lost
    @lead = current_company.leads.find(params[:id])
    if @lead.update_attributes(:status => 'lost')  
      flash[:notice] = "Schade, viel Erfolg beim naechsten Lead"  
      redirect_to leads_path()
    else  
      flash[:notice] = "Uups.. da ging was schief."  
      redirect_to @lead
    end    
  end

end
