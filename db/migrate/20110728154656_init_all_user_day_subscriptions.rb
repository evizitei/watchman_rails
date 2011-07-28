class InitAllUserDaySubscriptions < ActiveRecord::Migration
  def self.up
    User.find_each do |u|
      u.day_subscriptions = []
      u.save!
    end
  end

  def self.down
  end
end
