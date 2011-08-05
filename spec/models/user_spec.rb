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
  
  describe "#fullname" do
    subject { Factory(:user, :firstname => "Herbert", :lastname => "Meier" )}
    
    its(:fullname) {should == "Meier Herbert" }
  end
  
end

