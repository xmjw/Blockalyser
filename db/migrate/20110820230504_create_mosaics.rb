class CreateMosaics < ActiveRecord::Migration
  def self.up
    create_table :mosaics do |t|
      t.string :name
      t.integer :user
      t.integer :height
      t.integer :width
      t.integer :state
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :mosaics
  end
end
