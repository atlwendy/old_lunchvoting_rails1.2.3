# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 9) do

  create_table "groups", :force => true do |t|
    t.column "name", :string
  end

  create_table "restaurants", :force => true do |t|
    t.column "name",     :string,  :limit => 254
    t.column "group_id", :integer
  end

  create_table "usergroupmappings", :force => true do |t|
    t.column "group_id",     :integer
    t.column "emailaddress", :string
    t.column "hash",         :string
  end

  create_table "users", :force => true do |t|
    t.column "name",         :string
    t.column "emailaddress", :string
  end

  create_table "vetos", :force => true do |t|
    t.column "user_id",       :integer
    t.column "group_id",      :integer
    t.column "restaurant_id", :integer
  end

  create_table "votes", :force => true do |t|
    t.column "user_id",       :integer
    t.column "preference",    :integer
    t.column "created_at",    :date
    t.column "restaurant_id", :integer
    t.column "group_id",      :integer
  end

end
