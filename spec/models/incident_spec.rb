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
                             :priority=>3})}
                             
    it { should have_attribute_set(:address,"1504 W Lexington")}
    it { should have_attribute_set(:number,"201054321")}
    it { should have_attribute_set(:nature,"VIOLENT OVERDOSE")}
    it { should have_attribute_set(:cross_street_1,"Lexington Ct")}
    it { should have_attribute_set(:cross_street_2,"Georgetown Dr")}
    it { should have_attribute_set(:response_level,"Alpha")}
    it { should have_attribute_set(:priority,3)}
  end
  
  describe "finding most recent" do
    it "pulls the one with the later create date" do
      inc_1 = Incident.create(:created_at=>3.hours.from_now)
      inc_2 = Incident.create(:created_at=>3.hours.ago)
      Incident.most_recent.should == inc_1
    end
  end
end