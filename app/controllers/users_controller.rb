# This controller handles the login/logout function of the site.  
require "pivotal-tracker"
class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # render new.rhtml
  before_filter :login_required
  def index
    @users = User.find(:all)
  end
end
