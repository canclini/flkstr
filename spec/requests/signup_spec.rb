# -*- encoding : utf-8 -*-
require 'spec_helper'


# UseCases: 
# UC i4 - Sich registrieren

# describes signup

# Feautre: Ein Interessent will sich registrieren

describe "Signup Requests" do
  before do
     visit root_path
     click_link "Jetzt testen!"
   end

    # nromal flow
    it "registers company and user correctly if they do not exist" do
      fill_in "Firmenname", :with => 'Foobar GmbH'
      fill_in "Mailadresse", :with => 'foo@bar.com'
      fill_in "Passwort", :with => 'secret'
      fill_in "company_password_confirmation", :with => 'secret'
      check('user_terms_of_service')
      click_button "Konto erstellen"
      current_path.should eq(dashboard_path)
      page.should have_content("Erfolgreich registiert")
  end
  
  # e1
  it "does not register if the AGB is not accepted" do
    fill_in "Firmenname", :with => 'Foobar GmbH'
    fill_in "Mailadresse", :with => 'foo@bar.com'
    fill_in "Passwort", :with => 'secret'
    fill_in "company_password_confirmation", :with => 'secret'
    click_button "Konto erstellen"
    page.should have_content("Terms of service muss akzeptiert werden")
  end
  
  # e2
  it "does not register if the passwords do not match" do
    fill_in "Firmenname", :with => 'Foobar GmbH'
    fill_in "Mailadresse", :with => 'foo@bar.com'
    fill_in "Passwort", :with => 'secret'
    fill_in "company_password_confirmation", :with => 'incorrect'
    check('user_terms_of_service')
    click_button "Konto erstellen"
    page.should have_content("Password stimmt nicht")
  end
  
  # e3
  it "does not register if the password is too short (less than 4 chars)" do
    fill_in "Firmenname", :with => 'Foobar GmbH'
    fill_in "Mailadresse", :with => 'foo@bar.com'
    fill_in "Passwort", :with => '123'
    fill_in "company_password_confirmation", :with => '123'
    check('user_terms_of_service')
    click_button "Konto erstellen"
    page.should have_content("Password zu kurz")
  end
  
  # e4
  it "does not register if the email address is wrong" do
    fill_in "Firmenname", :with => 'Foobar GmbH'
    fill_in "Mailadresse", :with => 'fobar.com'
    fill_in "Passwort", :with => 'secret'
    fill_in "company_password_confirmation", :with => 'secret'
    check('user_terms_of_service')
    click_button "Konto erstellen"
    page.should have_content("Email Adresse stimmt nicht")
  end

  # e5
  it "does not register if the company name is missing" do
    fill_in "Firmenname", :with => ''
    fill_in "Mailadresse", :with => 'foo@bar.com'
    fill_in "Passwort", :with => 'secret'
    fill_in "company_password_confirmation", :with => 'secret'
    check('user_terms_of_service')
    click_button "Konto erstellen"
    page.should have_content("Firmenname muss")
  end
  
  # e6
  it "does not register if the company does exist" do
    create(:company, :name => 'Foobar GmbH')
    fill_in "Firmenname", :with => 'Foobar GmbH'
    fill_in "Mailadresse", :with => 'foo@bar.com'
    fill_in "Passwort", :with => 'secret'
    fill_in "company_password_confirmation", :with => 'secret'
    check('user_terms_of_service')
    click_button "Konto erstellen"
    
    page.should have_content("Firmenname ist bereits vergeben")
    within(:xpath, "//fieldset[contains(concat(' ',normalize-space(@class),' '),' field_with_errors ')]") do
      page.should have_content("Firmenname")
      page.should have_content("ist bereits vergeben")
    end
  end
  
  # e7
  it "does not register if the email address already exists" do
    create(:user, :email => 'foo@bar.com')
    fill_in "Firmenname", :with => 'Foobar GmbH'
    fill_in "Mailadresse", :with => 'foo@bar.com'
    fill_in "Passwort", :with => 'secret'
    fill_in "company_password_confirmation", :with => 'secret'
    check('user_terms_of_service')
    click_button "Konto erstellen"
    page.should have_content("Email ist bereits vergeben")
  end    
end
