require 'spec_helper'

describe WatchmanStatus do
  describe "when creating the current record" do
    before(:each) do
      WatchmanStatus.delete_all
    end
    
    let(:status){ WatchmanStatus.monitor }
    subject{ status }
    
    it{ should be_a WatchmanStatus }
    it{ should be_active }
  end
end
