class Projects < ActiveRecord::Migration
  def self.up
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
  end

  def self.down
  end
end
