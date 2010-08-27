class AddHashToMapping < ActiveRecord::Migration
  def self.up
	add_column :UserGroupMappings, :hash, :string
  end

  def self.down
	add_column :UserGroupMappings, :hash, :string
  end
end
