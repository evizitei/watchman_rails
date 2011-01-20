class CreateWatchmanStatuses < ActiveRecord::Migration
  def self.up
    create_table :watchman_statuses do |t|
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :watchman_statuses
  end
end
