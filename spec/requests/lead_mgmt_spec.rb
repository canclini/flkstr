# -*- encoding : utf-8 -*-
require 'spec_helper'

# UseCases: 
# UC n7 – Leads verwalten
# describes management of leads. 

describe "Leads Management Requests" do
  before do
    @user = Factory(:user)
    login @user
  end
  
  context "a new lead" do
    before do
      @lead = Factory(:lead, :company => @user.company)
    end
    it "can be accepted" do
      visit leads_path
      click_on @lead.request.name
      page.should_not have_content(@lead.source.name)
      click_on "Ja, unser Ding!"
      page.current_path.should eq(lead_path(@lead))
      page.should have_content(@lead.source.name)
    end
    
    it "can be rejected" do
      visit leads_path
      click_on @lead.request.name
      page.should_not have_content(@lead.source.name)
      click_on "nicht interessiert"
      page.current_path.should eq(leads_path())
      page.should_not have_content(@lead.request.name)
    end
    
    it "can be lost" do
      pending
    end
  end  
  
  context "an accepted lead" do
    before do
      @lead = Factory(:lead, :company => @user.company, :status => "accepted")
    end
    
    it "can be won" do
      visit leads_path
      click_on "In Bearbeitung"
      click_on @lead.request.name
      click_on "gewonnen"
      page.current_path.should eq(leads_path())
      page.should have_content "Gratulation zum gewonnenen Auftrag!"
      click_on "Gewonnen"
      page.should have_content @lead.request.name
    end
    
    it "can be manually set to lost" do
      visit leads_path
      click_on "In Bearbeitung"
      click_on @lead.request.name
      click_on "verloren"
      page.current_path.should eq(leads_path())
      page.should have_content "Schade"
      click_on "Verloren"
      page.should have_content @lead.request.name
    end
  end
end
