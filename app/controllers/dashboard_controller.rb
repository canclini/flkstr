class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    redirect_to new_company_path unless current_company
  end

end
