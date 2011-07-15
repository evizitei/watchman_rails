class DefaultAllUsersToSmsSubscriptions < ActiveRecord::Migration
  def self.up
    User.all.each do |u|
      u.is_sms_subscriber = true
      u.save!
    end
  end

  def self.down
  end
end
