class AddCommTypeFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_sms_subscriber, :boolean
    add_column :users, :is_email_subscriber, :boolean
  end

  def self.down
    remove_column :users, :is_email_subscriber
    remove_column :users, :is_sms_subscriber
  end
end
