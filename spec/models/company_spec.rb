require 'spec_helper'

describe Company do
  it { Factory(:company).should be_valid }
  
  
  describe "#to_param" do    
    company = Company.new
    company.name = "FooBar"
    company.save
    company.to_param.should == "#{company.id}-foobar"
  end
end
