class CreateGeoTargets < ActiveRecord::Migration
  def self.up
    create_table :geo_targets do |t|
      t.string :address
      t.string :city
      t.string :x_coord
      t.string :y_coord
      t.timestamps
    end
  end

  def self.down
    drop_table :geo_targets
  end
end
