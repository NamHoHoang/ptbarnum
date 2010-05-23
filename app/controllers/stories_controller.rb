# This controller handles the login/logout function of the site.  
require "pivotal-tracker"
class StoriesController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # render new.rhtml
  before_filter :login_required
  def index
    @projects = current_user.projects
    #Stores to db
    @stories = []
    @projects.each do |project|
      @project = PivotalTracker::Project.find(project.pid)    
      stories = @project.stories.all(:owned_by=>current_user.fullname)
      @stories[project.id] = stories
    end
  end
end
