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
    
    it "is not if its a status move" do
      @incident.update_attributes!(:apparatus=>["EMSAC"])
      @incident.should_not be_interesting
    end
    
    it "is interesting if any county unit is involved" do
      @incident.update_attributes!(:apparatus=>["E1401"])
      @incident.should be_interesting
    end
    
    it "is not if it's a waiting call" do
      @incident.update_attributes!(:apparatus=>["E1401","M231"],:number=>"W1234")
      @incident.should_not be_interesting
    end
  end
  
  describe "apparatus list formatting" do
    before(:each) do
      @incident = Incident.new
    end
    
    it "shows only apparatus if there is only 1" do
      @incident.apparatus = ["E1401"]
      @incident.cropped_apparatus_list.should == "E1401"
    end
    
    it "shows all apparatus if there are only 3" do
      @incident.apparatus = ["E1401","E801","M231"]
      @incident.cropped_apparatus_list.should == "E1401|E801|M231"
    end
    
    it "trails off after 3" do
      @incident.apparatus = ["E1401","E801","T805","T905","S104","M231"]
      @incident.cropped_apparatus_list.should == "E1401|E801|T805|..."
      @incident.apparatus_list.should == "E1401|E801|T805|T905|S104|M231"
    end
  end
  
  describe "long message formatting" do
    before(:each) do
      @incident = Incident.new(:address=>"1504 W Lexington",
                               :nature=>"Residential Structure Fire With People Trapped",
                               :apparatus=>["E1401","Q6","E801","T805","T905","S104","M231"],
                               :cross_street_1=>"Georgetown",
                               :cross_street_2=>"Lexington Ct")
                               
      @incident.stub!(:build_map_url).and_return("http://www.ggl.com/map")
    end
    
    it "formats a short version for sms" do
      @incident.formatted_message.should == "1504 W Lexington\nResidential Str\nE1401|Q6|E80\nGeorgetown\nLexington Ct\nhttp://www.ggl.com/map"
    end
    
    it "formats a long version for emails" do
      @incident.long_formatted_message.should == "1504 W Lexington\nResidential Structure Fire With People Trapped\nE1401|Q6|E801|T805|T905|S104|M231\nGeorgetown\nLexington Ct\nhttp://www.ggl.com/map"
    end
  end
end