class AddGroupToVote < ActiveRecord::Migration
  def self.up
      add_column :votes, :group, :string
  end

  def self.down
      remove_column :votes, :group
  end
end
