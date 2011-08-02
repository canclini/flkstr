require 'spec_helper'

describe "Authentication Requests" do

  it "logs in with known user" do
    user = Factory(:user)
    login user
    page.should_not have_content("Dashboard")
  end
  
  # it "logs out current user" do
  #   user = Factory(:user)
  #   login user
  #   visit logout_path
  #   visit user_path(user)
  #   page.should_not have_content("This is your profile.")
  # end
end