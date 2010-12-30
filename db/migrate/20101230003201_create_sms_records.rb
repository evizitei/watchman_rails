class CreateSmsRecords < ActiveRecord::Migration
  def self.up
    create_table :sms_records do |t|
      t.string :moonshado_id
      t.integer :credit
      t.string :stat

      t.timestamps
    end
  end

  def self.down
    drop_table :sms_records
  end
end
