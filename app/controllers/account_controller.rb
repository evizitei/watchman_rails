class AccountController < ApplicationController
  before_filter :authenticate_user!
  
  def manage
  end
  
end
