require 'spec_helper'

describe "flockstreet Website" do
  before { visit root_path }
  it "has a start page" do
    page.should have_content("flockstreet")
    page.should have_content("Jetzt testen!")
  end

  it "has a Abos and Prices" do
    click_link "Abos"
    page.should have_content("Scale")
    page.should have_content("Connect")
    page.should have_content("Ready")
  end

  it "explains what is flockstreet" do
    click_link "Was ist flockstreet"
    page.should have_content("Dienstleister finden")
    page.should have_content("gewinnen")
  end

  it "has an about page" do
    click_link "Uns"
    page.should have_content("Caroline")
    page.should have_content("Marcel")
  end

  it "has AGBs" do
    click_link "AGB"
    page.should have_content("Nutzungsbedingungen")
  end

  it "has an Impressum" do
    click_link "Impressum"
    page.should have_content("Impressum")
    page.should have_content("flockstreet GmbH")
  end
  
end