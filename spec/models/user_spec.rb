require 'spec_helper'

describe User do
  it { should allow_value("15732395840").for(:phone) }
  it { should_not allow_value("test").for(:phone) }
  it { should_not allow_value("573-239-5840").for(:phone) }
  it { should validate_presence_of(:phone)}
  
  describe "phone attribute" do
    it "should strip dashes" do
      User.new(:phone=>"1-573-239-5840").phone.should == "15732395840"
    end
    
    it "strips parens" do
      User.new(:phone=>"1(573)2395840").phone.should == "15732395840"
    end    
    
    it "removes whitespace from either side" do
      User.new(:phone=>"  15732395840  ").phone.should == "15732395840"
    end
    
    it "strips whitespace from within" do
      User.new(:phone=>"1 573 239 5840").phone.should == "15732395840"
    end
    
    it "reformats a common phone format" do
      User.new(:phone=>"1 (573) 239-5840 ").phone.should == "15732395840"
    end
  end
end
