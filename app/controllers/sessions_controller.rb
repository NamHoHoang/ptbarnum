# This controller handles the login/logout function of the site.  
require "pivotal-tracker"
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # render new.rhtml
  def new

  end

  def create
    @email=params[:email]  
    begin
      PivotalTracker::Client.token(params[:email], params[:password])
    rescue
      flash[:login_error] = "Invalid login or password"
      render :action =>"new"
    else
      self.current_user = User.authenticate(params[:email], params[:password])
      if logged_in?
        user = self.current_user
        user.login = params[:email]
        user.email = params[:email]
        user.password = params[:password]
        user.save
        self.current_user = user
      else
        user = User.new
        user.login = params[:email]
        user.email = params[:email]
        user.password = params[:password]
        user.fullname = params[:email]
        user.save
        self.current_user =user
      end
      redirect_to projects_path
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You have been logged out."
    PivotalTracker::Client.token=''
    redirect_back_or_default('/')
  end
  
end
