class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    current_user.add_subscription!(params[:apparatus])
    redirect_to my_account_path 
  end
end
