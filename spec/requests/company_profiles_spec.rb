require 'spec_helper'

# UseCases: 
# UC n2, UCn2-Firmenprofil_erfassen.odt

describe "Company Profile" do
  
  before do
    @user = Factory(:user)
    login @user
  end
  
  it "can be searched by company name and be displayed" do
    profile = Factory(:company)
  #  login @user
    fill_in "query", :with => profile.name
    click_button "Suchen"
    page.should have_content(profile.name)
    click_link profile.name
    current_path.should eq(company_path(profile))
  end
  
  context "the users company profile" do
    before do
       visit company_path(@user.company)
     end
    
    # normal flow
    it "can be shown" do
      page.should have_content(@user.company.name)
    end
    
    # normal flow
    it "can be edited" do
      click_link "editieren"
      page.should have_content("Firmenprofil von #{@user.company.name} editieren")
      fill_in "company_history", :with => "lorem ipsum dolor..."
      click_button "Speichern"
      current_path.should eq(company_path(@user.company))
      page.should have_content("Profil wurde aktualisiert")
      page.should have_content("lorem ipsum dolor...")
    end

    context "a different company profile page" do
      before do
         @othercompany = Factory(:company)
         visit company_path(@othercompany)
       end

      it "can be shown" do
        page.should have_content(@othercompany.name)
      end

      it "cannot be edited via link" do
        page.should_not have_content("editieren")
      end
      
      it "cannot be edited via direct url" do
        visit edit_company_path(@othercompany)
        current_path.should eq(dashboard_path)
        page.should have_content("Unerlaubte Aktion")
      end
    end
  end
end