require 'spec_helper'

describe Addresser do
  it "can handle a normal address" do
    addy = Addresser.build_full_address("4305 BETHANY DR W-BC")
    addy.should == "4305+BETHANY+DR+W,+BOONE+COUNTY,+MO"
  end
  
  it "can handle an intersection" do
    addy = Addresser.build_full_address("GILLESPIE BRIDGE RD W-BC/COATS LN S-BC")
    addy.should == "GILLESPIE+BRIDGE+RD+W,+BOONE+COUNTY,+MO&COATS+LN+S,+BOONE+COUNTY,+MO"
  end
  
  it "can deal with a mile marker" do
    addy = Addresser.build_full_address("1306 I70 E-CO")
    addy.should == "38.96061154690,-92.26153534140"
  end
  
  describe "mile markers" do
    it "extracts a fractional mile marker" do
      Addresser.extract_mile_marker("1306 I70 E-CO").should == "130.6"
    end
    
    it "works for full lat long against strange marks" do
      Addresser.build_full_address("1362 I70 W-BC").should == "38.95549363270,-92.15822746970"
    end
    
    it "works for full lat long against 1326" do
      Addresser.build_full_address("1326 I70 E-BC").should == "38.96013322250,-92.22444433720"
    end
    
    it "works for full lat long against 1330" do
      Addresser.build_full_address("1330 I70 W-BC").should == "38.95918203070,-92.21712304020"
    end
  end
  
  describe "I70 crossover" do
    describe "crossover test" do
      it "recognizes a crossover" do
        Addresser.is_i70_crossover("I70 E-BC/ROUTE Z N-BC").should be
        Addresser.is_i70_crossover("ROUTE Z N-BC/I70 E-BC").should be
      end
      
      it "ignores non crossovers" do
        Addresser.is_i70_crossover("1330 I70 W-BC").should_not be
        Addresser.is_i70_crossover("GILLESPIE BRIDGE RD W-BC/COATS LN S-BC").should_not be
        Addresser.is_i70_crossover("4305 BETHANY DR W-BC").should_not be
      end
    end
    
    # it "works at route Z" do 
    #       Addresser.build_full_address("I70 E-BC/ROUTE Z N-BC").should == "38.95549363270,-92.15822746970"
    #     end
  end
  
  describe "Routes which are actually missouri highways" do
    describe "discerning highways" do
      specify{ Addresser.is_missouri_highway("5450 ROUTE Z N-BC").should be }
      specify{ Addresser.is_missouri_highway("5450 ROUTE Z N").should be }
      specify{ Addresser.is_missouri_highway("3900 HIGHWAY WW E-BC").should be }
      specify{ Addresser.is_missouri_highway("4305 BETHANY DR W-BC").should_not be }
      specify{ Addresser.is_missouri_highway("1330 I70 W-BC").should_not be }
    end
    
    specify{ Addresser.build_full_address("5450 ROUTE Z N-BC").should == "5450+MISSOURI+Z,+BOONE+COUNTY,+MO"}
    specify{ Addresser.build_full_address("5450 ROUTE Z N").should == "5450+MISSOURI+Z,+BOONE+COUNTY,+MO" }
    specify{ Addresser.build_full_address("3900 HIGHWAY WW E-BC").should == "3900+MISSOURI+WW,+BOONE+COUNTY,+MO" }
    specify{ Addresser.build_full_address("3900 HIGHWAY WW E").should == "3900+MISSOURI+WW,+BOONE+COUNTY,+MO" }
  end
end
