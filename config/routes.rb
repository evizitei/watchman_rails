MedicWatcher::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  root  :to=>"account#manage"
  match "my_account" => "account#manage"
  match "test_message" => "account#test_sms"
  match "edit_preferences" => "account#edit_preferences",:as=>:edit_preferences
  match "save_preferences" => "account#save_preferences",:as=>:save_preferences
  match "send_test_message" => "main#test_message"
  
  resources :subscriptions do 
    collection do
      post "day"
    end
  end
  
  resources :incidents 
  
  match "cancel_subscription/:apparatus" => "subscriptions#destroy"
  match "cancel_day_subscription/:apparatus" => "subscriptions#destroy_day"
end
