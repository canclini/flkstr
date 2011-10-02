# -*- encoding : utf-8 -*-
class AssociatesController < ApplicationController
  def index
    @company = current_company
    @associates = @company.associates
    @followers = @company.followers
  end

  def show
    redirect_to company_path(params[:id])
  end

  def new   
    @associate = Association.new(:associate_id => params[:company_id], :company_id => current_company.id)
    @company = Company.find(params[:company_id])
  end

  def create
    @company = current_company
    @associate = Association.new(params[:associate])
    if @associate.save
      redirect_to company_associates_path(current_company)
    else
      redirect_to new_company_associate_path(params[:associate][:associate_id])
    end
  end
    
  def destroy
    @associate = current_company.associations.find_by_associate_id(params[:id])
    @associate.destroy
    flash[:notice] = "Aus dem Netzwerk entfernt."
    redirect_to company_associates_path(current_company)
  end
end
