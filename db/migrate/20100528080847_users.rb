class Users < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string   "fullname",         :limit => 100
      t.string   "login"
      t.string   "email"
      t.string   "crypted_password", :limit => 40
      t.string   "salt",             :limit => 40
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
