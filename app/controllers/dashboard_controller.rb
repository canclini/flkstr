class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    redirect_to new_company_path unless current_company
    @leads = current_company.leads.new_or_accepted
    @company = current_company
    @latest_update = @company.updates.last
  end

end
