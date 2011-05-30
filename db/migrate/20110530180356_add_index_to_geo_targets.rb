class AddIndexToGeoTargets < ActiveRecord::Migration
  def self.up
    add_index :geo_targets,:address
  end

  def self.down
    remove_index :geo_targets,:address
  end
end
