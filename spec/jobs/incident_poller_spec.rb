require 'spec_helper'

describe IncidentPoller do
  
  it { should be_a_delayed_job_worker }
  
  describe "list of new calls" do
    before(:each) do
      ["12345","67890","24680"].each do |id|
        Factory(:incident,:number=>id)
      end
      current_calls = ["12345","23456","67890","78901","24680","13579"]
      Watchman::CallWatcher.stub(:new){ double("call watcher",:current_call_incident_numbers=>current_calls)}
    end
    
    subject{ IncidentPoller.new.new_calls }
    
    context "because it ignores calls already in the database" do
      it { should_not include("12345") }
      it { should_not include("67890") }
      it { should_not include("24680") }
    end
    
    context "because it retains calls not in the database" do
      it { should include("23456") }
      it { should include("78901") }
      it { should include("13579") }
    end
    
  end
  
  describe "creating a new incident" do
    before(:each) do
      rec = double("watchman call record",:address=>"1504 W Lexington",
                                           :incident_number=>"201054321",
                                           :nature=>"VIOLENT OVERDOSE",
                                           :cross_streets=>["Lexington Ct","Georgetown Dr"],
                                           :response_level=>"Alpha",
                                           :priority=>3)
      
      IncidentPoller.new.build_incident_from_call_record(rec)
    end
   
    subject{ Incident.last }
    
    it{ should have_attribute_set(:address,"1504 W Lexington")}
    it{ should have_attribute_set(:number,"201054321")}
    it{ should have_attribute_set(:nature,"VIOLENT OVERDOSE")}
    it{ should have_attribute_set(:cross_street_1,"Lexington Ct")}
    it{ should have_attribute_set(:cross_street_2,"Georgetown Dr")}
    it{ should have_attribute_set(:response_level,"Alpha")}
    it{ should have_attribute_set(:priority,3)}
  end
end