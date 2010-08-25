class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :needs_company!

  def show
  end

  def new
    redirect_to signup_path unless Plan::NAMES.include? params[:plan]
    @plan = Plan.find_by_name(params[:plan])
  end

  def edit
  end

end
