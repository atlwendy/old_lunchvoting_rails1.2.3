class CreateUsergroupmappings < ActiveRecord::Migration
  def self.up
    create_table :usergroupmappings do |t|
        t.column :group_id, :int
        t.column :emailaddress, :string
    end
  end

  def self.down
    drop_table :usergroupmappings
  end
end
