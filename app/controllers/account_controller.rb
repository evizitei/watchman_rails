class AccountController < ApplicationController
  before_filter :authenticate_user!
  
  def manage
    @status_record = WatchmanStatus.monitor
  end
  
  def test_sms
    current_user.send_sms!("test message from BCFPD Watchman")
    redirect_to my_account_path
  end
  
  def edit_preferences
  end
  
  def save_preferences
    current_user.update_attributes!(params[:user])
    redirect_to :action=>:manage
  end
end
