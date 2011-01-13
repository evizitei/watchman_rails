class AccountController < ApplicationController
  before_filter :authenticate_user!
  
  def manage
  end
  
  def test_sms
    current_user.send_sms!("test message from BCFPD Watchman")
  end
end
