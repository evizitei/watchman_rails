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
  
  let(:incident_params){{:address=>"1504 W Lexington",
                                       :incident_number=>"201054321",
                                       :nature=>"VIOLENT OVERDOSE",
                                       :cross_streets=>["Lexington Ct","Georgetown Dr"],
                                       :response_level=>"Alpha",
                                       :priority=>3,
                                       :apparatus=>["E1401","Q6","M231"]}}
                                       
  describe "creating a new incident" do
    before(:each) do
      rec = double("watchman call record",incident_params)
      
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
    it{ should have_attribute_set(:apparatus,["E1401","Q6","M231"])}
  end
  
  describe "performing it's job" do
    before(:each) do
      call = double("call record",incident_params)
      watchman = Watchman::CallWatcher.new
      watchman.should_receive(:current_call_incident_numbers).and_return(["201054321"])
      watchman.should_receive(:info_for).with("201054321").and_return(call)
      Watchman::CallWatcher.stub(:new){ watchman }
    end
    
    it "creates a record for the new call" do
      IncidentPoller.new.perform
      Incident.most_recent.number.should == "201054321"
    end
    
    it "should dispatch a notification event for a new call" do
      incident = Incident.new
      incident.should_receive(:dispatch_notifications!)
      Incident.stub(:create!){ incident }
      IncidentPoller.new.perform
    end
    
    it "should enqueue itself for 30 seconds later" do
      Timecop.freeze
      IncidentPoller.new.perform
      Delayed::Job.last.run_at.should == (Time.now + 30.seconds)
      Timecop.return
    end
  end
end