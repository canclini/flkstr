class WebsiteController < ApplicationController
  def index
    @signedupcompanies = Company.with_logo
  end

  def about
  end

  def terms
  end

  def contact
  end

end
