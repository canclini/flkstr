# -*- encoding : utf-8 -*-
require 'spec_helper'

# UseCases: 
# UC n4, UCn4-Aufträge verwalten.odt
# UC n5 – Offertanfragen / Aufträge erfassen
# describes management of requests. 

describe "Request Management Requests" do
  before do
    @user = create(:user)
    login @user
  end
  
  it "lists open requests" do
    @req = create(:request, :company => @user.company)
    visit requests_path
    page.should have_content(@req.name)
  end
  
  it "creates a new requests as draft" do
      visit requests_path
      click_on "Auftrag erfassen"
      click_on "speichern"
      page.should have_content("Konnte auftrag nicht speichern")
      fill_in "Auftrags Titel", :with => "New WebDesign for us!"
      fill_in "Beschreibung", :with => "Unsere Firma braucht ein neues Webdesign"
      click_on "speichern"
      page.current_path.should eq(request_path(Request.last))
      page.should have_content("Der Auftrag wurde erfasst. Wir suchen nach geeigneten Lieferanten")
      page.should have_content("New WebDesign for us!")
      page.should have_content("ENTWURF")
  end
  
  it "does not create a new request without a title" do
    visit requests_path
    click_on "Auftrag erfassen"
    fill_in "Beschreibung", :with => "New WebDesign for us!"    
    click_on "speichern"
    page.should have_content("Konnte auftrag nicht speichern")
    page.should have_content("Auftrags Titel muss")
  end

  it "does not create a new request without a description" do
    visit requests_path
    click_on "Auftrag erfassen"
    fill_in "Auftrags Titel", :with => "New WebDesign for us!"    
    click_on "speichern"
    page.should have_content("Konnte auftrag nicht speichern")
    page.should have_content("Beschreibung muss")
  end
  
  it "creates a new request and publish it" do
    visit requests_path
    click_on "Auftrag erfassen"
    fill_in "Auftrags Titel", :with => "New WebDesign for us!"
    fill_in "Beschreibung", :with => "Unsere Firma braucht ein neues Webdesign"
    click_on "freigeben"
    page.current_path.should eq(request_path(Request.last))
    page.should have_content("Der Auftrag wurde erfasst. Wir suchen nach geeigneten Lieferanten")
    page.should have_content("New WebDesign for us!")
    page.should_not have_content("ENTWURF")    
  end
  
  it "discards a request" do
    visit requests_path
    click_on "Auftrag erfassen"
    fill_in "Auftrags Titel", :with => "New WebDesign for us!"
    fill_in "Beschreibung", :with => "Unsere Firma braucht ein neues Webdesign"
    click_on "verwerfen"
    page.current_path.should eq(requests_path)
    page.should have_content("Der Auftrag wurde verworfen")
  end
      
  it "shows all open requests" do
    requests_list = FactoryGirl.create_list(:request, 3, :company => @user.company)
    visit requests_path
    for request in requests_list do
      page.should have_content(request.name)
    end
  end
    
  context "handling drafts" do
    # e1
    before do
      @req = Factory(:request, :status => "draft", :company => @user.company)
    end
    
    it "should display a draft request only in drafts" do
      visit requests_path
      page.should_not have_content(@req.name)
      click_link "Entw" # problems with Umlaute
      page.should have_content(@req.name)
    end
    
    it "should delete the draft if I want so" do
      visit requests_filter_path(:status => "draft")
      click_link @req.name
      page.should have_content @req.description
      click_link "verwerfen"
      current_path.should eq(requests_filter_path(:status => "draft"))
      page.should_not have_content @req.name
    end
    
    it "can edit a draft request and publish it" do
      visit request_path(@req)
      page.should have_content("ENTWURF")
      click_on "editieren"
      fill_in "Auftrags Titel", :with => "Newer WebDesign!"
      click_on "freigeben"
      page.current_path.should eq(request_path(@req))
      page.should have_content("Newer WebDesign!")
      page.should_not have_content("ENTWURF")
    end    
  end
  
  context "handling published requests" do
    before(:each) do
      @req = create(:request, :status => "open", :company => @user.company)
      visit request_path(@req)
    end
    
    it "show the number of generated leads" do
      page.should have_content("diesen Auftrag informiert") #problems with Umlaut
    end
    
    it "recalls a request" do
      click_on "gezogen" #problems with Umlaut
      pending
    end
    
    it "assigns a request" do
      pending
    end
  end
end
