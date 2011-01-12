require 'spec_helper'

describe Apparatus do
  describe "county trucks" do
    subject{ Apparatus.county }
    
    it { should include("E1401")}
  end
end
