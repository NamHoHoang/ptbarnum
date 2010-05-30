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
      stories.each do |story|
        r_story = Story.find(:first, :conditions=>["pid=?", story.id])
        if r_story.nil?
          r_story = Story.new  
        end
        r_story.project_id = project.id
        r_story.pid = story.id
        r_story.story_type = story.story_type
        r_story.url = story.url
        r_story.estimate = story.estimate
        r_story.current_state = story.current_state
        #r_story.lighthouse_id = story.lighthouse_id
        #r_story.lighthouse_url = story.lighthouse_url
        r_story.description = story.description
        r_story.name = story.name
        r_story.requested_by = story.requested_by
        r_story.owned_by = story.owned_by
        r_story.created_at = story.created_at
        r_story.accepted_at = story.accepted_at
        r_story.labels = story.labels
        r_story.save
      end
    end
  end
  def move
    target = params[:target]
    move = params[:move]
    story_pid = params[:story]
    story = Story.find(:first, :conditions=>["pid=?", story_pid]) 
    project_pid = story.project.pid
    @project = PivotalTracker::Project.find(project_pid)    
    story = @project.stories.find(story_pid.to_i)
    begin
      story.move(target, move)
      @error = false
    rescue
      @error = true
    end
    respond_to do |format|
      format.js {
        if @error
          render :json => {:message => "Updated fail!"}
        else    
          render :json => {:message => "Updated successfull!"}
        end    
      }
    end
  end
end
