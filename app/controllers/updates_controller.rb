class UpdatesController < ApplicationController

  def create
    @company = current_company
    @update = @company.updates.build(:message => params[:update])
    if @update.save
        flash[:notice] = "Dein Update wurde veroeffentlicht"
    else
        flash[:error] = "Da ging was schief..."
    end
    redirect_to dashboard_path()
  end
  
end
