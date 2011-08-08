require 'spec_helper'

describe User do

  it { Factory(:user).should be_valid }
  
  it "should require an email" do
    subject.should_not be_valid
    subject.should have_at_least(1).error_on(:email)
    subject.email = "someone@example.com"
    subject.password = "secret"
    subject.should be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = Factory.build(:user, :email => address)
      valid_email_user.should be_valid
    end
  end
  
  it "should not accept wrong email addresses" do
    addresses = %w[usercom The\ @foo.bar.org first.last@foo]
    addresses.each do |address|
      valid_email_user = Factory.build(:user, :email => address)
      valid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    Factory(:user, :email => "foo@example.com")
    user_with_duplicate_email = Factory.build(:user, :email => "foo@example.com")
    user_with_duplicate_email.should_not be_valid
  end

  describe "Notifications" do
    context "when user is new" do
      before { User.new }
      
      it "should have a weekly notification" do
        subject.notify_symbols.should include :weekly
      end
      
      it "should be notifed on all items" do
        %w[leads messages network].each do |attr|
          subject.notifiers_symbols.should include attr.to_sym
          subject.notifiers.should include attr          
        end  
      end
      
      it "notification items can be changed" do
        items = ["leads", "messages"]
        subject.notifiers = items

        items.each do |attr|
          subject.notifiers_symbols.should include attr.to_sym
          subject.notifiers.should include attr
        end  
          subject.notifiers_symbols.should_not include :network
      end
        
    end
  end
    
  describe "#fullname" do
    subject { Factory(:user, :firstname => "Herbert", :lastname => "Meier", :email => "h.meier@example.com" )}
    
    its(:fullname) {should == "Meier Herbert" }
    
    it "should give the email if first or lastname are missing" do
      subject.firstname = ""
      subject.fullname == "h.meier@example.com"
    end 
  end
  
  describe "#send_password_reset" do
    let(:user) { Factory(:user) }

    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)
    end

    it "saves the time the password reset was sent" do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end

    it "delivers email to user" do
      user.send_password_reset
      last_email.to.should include(user.email)
    end
  end
end