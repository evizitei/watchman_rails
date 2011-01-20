class WatchmanStatus < ActiveRecord::Base
  class << self
    def monitor
      WatchmanStatus.last || WatchmanStatus.create(:active=>true)
    end
    
    def active!
      monitor.update_attributes!(:active=>false)
    end
    
    def kill!
      monitor.update_attributes!(:active=>false)
    end
  end
  
  def active?
    active
  end
end
