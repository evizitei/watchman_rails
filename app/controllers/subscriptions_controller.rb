class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    current_user.add_subscription!(params[:apparatus])
    redirect_to my_account_path 
  end
  
  def day
    current_user.add_day_subscription!(params[:apparatus])
    redirect_to my_account_path 
  end
  
  def destroy
    current_user.remove_subscription!(params[:apparatus])
    redirect_to my_account_path
  end

  def destroy_day
    current_user.remove_day_subscription!(params[:apparatus])
    redirect_to my_account_path
  end
end
