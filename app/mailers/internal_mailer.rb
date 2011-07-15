class InternalMailer < ActionMailer::Base  
  def polling_error(message)
    @message = message
    mail(:to => ["ethan.vizitei@gmail.com","jcreamer@bcfdmo.com"], :subject => "Watchman Error", :from => "noreply@bcfpdwatchman.com")  
  end 
  
  def generic_message(user,message) 
    @message = message
    mail(:to => user.email, :subject => "Watchman Alert", :from => "noreply@bcfpdwatchman.com")  
  end
end