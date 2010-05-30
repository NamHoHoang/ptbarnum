require 'digest/sha1'
class Story < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  belongs_to :project
end