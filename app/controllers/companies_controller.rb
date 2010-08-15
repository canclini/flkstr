class CompaniesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  
  def index
  end

  def show
  end

  def new
  end

  def update
  end

end
