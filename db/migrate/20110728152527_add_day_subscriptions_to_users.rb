class AddDaySubscriptionsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :day_subscriptions, :text
  end

  def self.down
    remove_column :users, :day_subscriptions
  end
end
