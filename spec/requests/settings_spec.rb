# -*- encoding : utf-8 -*-
require 'spec_helper'

# UseCases: 
# 

describe "Settings Requests" do
  before do
    @user = create(:user)
    login @user
  end
  
  it "displays the settings page" do
    click_on "Einstellungen"
    page.current_path.should eq(settings_path)
    page.should have_content("Einstellungen")
  end
end