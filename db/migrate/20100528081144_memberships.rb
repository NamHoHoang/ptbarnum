class Memberships < ActiveRecord::Migration
  def self.up
    create_table "memberships", :force => true, :id => false do |t|
      t.integer "user_id"
      t.integer "project_id"
      t.string  "role",       :limit => 50
    end
  end

  def self.down
  end
end
