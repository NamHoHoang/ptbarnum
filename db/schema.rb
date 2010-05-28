# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100528081144) do

  create_table "memberships", :force => true do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.string  "role",       :limit => 50
  end

  add_index "memberships", ["id"], :name => "id"

  create_table "projects", :force => true do |t|
    t.integer  "pid"
    t.string   "name",                              :limit => 200
    t.integer  "iteration_length"
    t.string   "week_start_day",                    :limit => 50
    t.string   "point_scale",                       :limit => 200
    t.string   "account",                           :limit => 200
    t.string   "velocity_scheme",                   :limit => 200
    t.integer  "current_velocity"
    t.integer  "initial_velocity"
    t.integer  "number_of_done_iterations_to_show"
    t.string   "labels",                            :limit => 200
    t.boolean  "allow_attachments",                                :default => false, :null => false
    t.boolean  "public",                                           :default => false, :null => false
    t.boolean  "use_https",                                        :default => false, :null => false
    t.boolean  "bugs_and_chores_are_estimatable",                  :default => false, :null => false
    t.boolean  "commit_mode",                                      :default => false, :null => false
    t.datetime "last_activity_at"
  end

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
