require 'spec_helper'

describe Incident do
  subject { Incident.new }
  
  it { should be_a MongoMapper::Document}
  
  describe "using mass assignment" do
    subject { Incident.new( {:address=>"1504 W Lexington",
                             :number=>"201054321",
                             :nature=>"VIOLENT OVERDOSE",
                             :cross_street_1=>"Lexington Ct",
                             :cross_street_2=>"Georgetown Dr",
                             :response_level=>"Alpha",
                             :priority=>3,
                             :apparatus=>["E1401","Q6","M231"]})}
                             
    it { should have_attribute_set(:address,"1504 W Lexington")}
    it { should have_attribute_set(:number,"201054321")}
    it { should have_attribute_set(:nature,"VIOLENT OVERDOSE")}
    it { should have_attribute_set(:cross_street_1,"Lexington Ct")}
    it { should have_attribute_set(:cross_street_2,"Georgetown Dr")}
    it { should have_attribute_set(:response_level,"Alpha")}
    it { should have_attribute_set(:priority,3)}
    it { should have_attribute_set(:apparatus,["E1401","Q6","M231"])}
  end
  
  describe "finding most recent" do
    it "pulls the one with the later create date" do
      inc_1 = Incident.create(:created_at=>3.hours.from_now)
      inc_2 = Incident.create(:created_at=>3.hours.ago)
      Incident.most_recent.should == inc_1
    end
  end
  
  it "can find by single apparatus" do
    Incident.create!( {:apparatus=>["E1401","Q6","M231"]})
    Incident.for_apparatus("Q6").size.should == 1
  end
  
  describe "whether a call is interesting" do
    before(:each) do
      @incident = Incident.create!( {:apparatus=>["M231"]})
    end
    
    it "is not if it only has a medic unit" do
      @incident.should_not be_interesting
    end
    
    it "is interesting if any county unit is involved" do
      @incident.update_attributes!(:apparatus=>["E1401"])
      @incident.should be_interesting
    end
  end
end