class Stories < ActiveRecord::Migration
  def self.up
    create_table "stories", :force => true do |t|
      t.integer  "pid"
      t.integer  "project_id"
      t.string   "story_type",     :limit => 50
      t.string   "url",            :limit => 200
      t.integer  "estimate"
      t.string   "current_state",  :limit => 50
      t.integer  "lighthouse_id"
      t.string   "lighthouse_url", :limit => 200
      t.text     "description"
      t.string   "name",           :limit => 200
      t.string   "requested_by",   :limit => 200
      t.string   "owned_by",       :limit => 200
      t.datetime "created_at"
      t.datetime "accepted_at"
      t.string   "labels",         :limit => 200
    end
  end

  def self.down
  end
end
