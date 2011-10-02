# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Company do
  it { Factory(:company).should be_valid }
  
  it "automatically generates permalink when creating company" do
    company = Factory(:company, :name => ' Hello_ *World* 2.1. ')
    company.permalink.should eq('hello-world-2-1')
  end
  
  it "finds published" do
    a = Factory(:company, :name => "Foobar GmbH")
    b = Factory(:company, :name => "Foobar AG")
    c = Factory(:company, :name => "Example Company")
    Company.search("Foo").should include(a)
    Company.search("Foo").should include(b)
    Company.search("Foo").should_not include(c)
  end
   
  describe "#to_param" do
    it "returns the company id with a the name" do
      company = Company.new
      company.name = "FooBar"
      company.save
      company.to_param.should == "#{company.id}-foobar"
    end
  end
  
  describe "#as_json" do
    before { @company = Factory(:company, :name => "Example AG") }
    
    it "should return the company as json object" do
      json_obj = @company.as_json
      json_obj["id"] == @company.id
      json_obj["name"].should == "Example AG"
      json_obj["value"].should == "Example AG"
    end
  end
  
  describe "#add_request?" do
    before do
      @company = Factory(:company)
      @plan = mock(Plan)
      @company.stub_chain(:plan, :requests).and_return(10)
    end
    
    it "if requests# included in the plan are not exceeded" do
      @company.stub_chain(:requests, :this_month, :size).and_return(5)
      @company.add_request?.should == true
    end
    
    it "is false if requests# are equal the montly limit" do
      @company.stub_chain(:requests, :this_month, :size).and_return(10)
      @company.add_request?.should == false
    end
    
    it "is false if requests# are above the montly limit" do
      @company.stub_chain(:requests, :this_month, :size).and_return(15)
      @company.add_request?.should == false
    end
  end
  
  describe "#accept_lead?" do
    before do
      @company = Factory(:company)
      @plan = mock(Plan)
      @company.stub_chain(:plan, :leads).and_return(10)
    end
    
    it "if leads# included in the plan are not exceeded" do
      @company.stub_chain(:leads, :this_month, :size).and_return(5)
      @company.accept_lead?.should == true
    end
    
    it "is false if leads# are equal the montly limit" do
      @company.stub_chain(:leads, :this_month, :size).and_return(10)
      @company.accept_lead?.should == false
    end
    
    it "is false if leads# are above the montly limit" do
      @company.stub_chain(:leads, :this_month, :size).and_return(15)
      @company.accept_lead?.should == false
    end
  end
  
  describe "#main_address" do    
    it "should return one single object of Class Address" do
      company = Factory(:company)
      
      company.main_address.class.should == Address
    end
  end
  
end
