class AddVetoTable < ActiveRecord::Migration
  def self.up
      create_table :vetos do |t|
          t.column :user_id, :int
          t.column :group_id, :int
          t.column :restaurant_id, :int
      end
  end

  def self.down
      drop_table :vetos
  end
end
