class CreateOrganizationIds < ActiveRecord::Migration
  def self.up
    create_table :organization_ids do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :organization_ids
  end
end
