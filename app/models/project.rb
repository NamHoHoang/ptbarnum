require 'digest/sha1'
class Project < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  has_many :memberships
end