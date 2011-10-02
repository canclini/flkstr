# -*- encoding : utf-8 -*-
class WebsiteController < ApplicationController
  skip_before_filter :force_subdomain
  def index
    #@signedupcompanies = Company.with_logo
  end
  
  def flockstreet
    
  end

  def about
  end

  def terms
  end

  def contact
  end

end
