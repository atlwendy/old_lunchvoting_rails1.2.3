class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
    end
  end

  def self.down
    drop_table :votes
  end
end
