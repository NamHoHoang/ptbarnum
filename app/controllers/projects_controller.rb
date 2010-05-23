# This controller handles the login/logout function of the site.  
require "pivotal-tracker"
class ProjectsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # render new.rhtml
  before_filter :login_required
  def index
    @projects = PivotalTracker::Project.all
    #Stores to db
    @projects.each do |project|
        cur_project = Project.find(:first, :conditions=>["pid=?", project.id])
        if cur_project.nil?
          cur_project = Project.new
        end
        cur_project.pid = project.id
        cur_project.name = project.name
        cur_project.iteration_length = project.iteration_length
        cur_project.week_start_day = project.week_start_day
        cur_project.point_scale = project.point_scale
        #cur_project.account = project.account
        cur_project.velocity_scheme = project.velocity_scheme
        cur_project.current_velocity = project.current_velocity
        cur_project.initial_velocity = project.initial_velocity
        #cur_project.number_of_done_iterations_to_show = project.number_of_done_iterations_to_show
        #cur_project.labels = project.labels
        #cur_project.allow_attachments = 1 if project.allow_attachments == "true"
        #cur_project.public = 1 if project.public == "true"
        #cur_project.use_https = 1 if project.use_https == "true"
        #cur_project.bugs_and_chores_are_estimatable = 1 if project.bugs_and_chores_are_estimatable=="true"
        #cur_project.commit_mode = 1 if project.commit_mode== "true"
        cur_project.last_activity_at = project.last_activity_at
        cur_project.save
        @members = project.memberships.all
        @members.each do |member|
        user = User.find(:first, :conditions=>["email=?", member.email])
        if user.nil?
          user = User.new
          user.login = member.email    
          user.email = member.email
          user.password = member.email
          user.fullname = member.name
          user.save
        else
          user.fullname = member.name
          user.save
        end
        #associate user to project
        membership = Membership.find(:first, :conditions=>["project_id=? and user_id=?", params[:id].to_i, user.id])
        if membership.nil?
          membership = Membership.new
          membership.project_id = params[:id].to_i
          membership.user_id = user.id
          membership.role = member.role
          membership.save
        else 
          membership.role = member.role
          membership.save
        end
    end
    end
  end
  def show
    @project = PivotalTracker::Project.find(params[:id].to_i)
    @members = @project.memberships.all
    @members.each do |member|
        user = User.find(:first, :conditions=>["email=?", member.email])
        if user.nil?
          user = User.new
          user.login = member.email    
          user.email = member.email
          user.password = member.email
          user.fullname = member.name
          user.save
        else
          user.fullname = member.name
          user.save
        end
        #associate user to project
        membership = Membership.find(:first, :conditions=>["project_id=? and user_id=?", params[:id].to_i, user.id])
        if membership.nil?
          membership = Membership.new
          membership.project_id = params[:id].to_i
          membership.user_id = user.id
          membership.role = member.role
          membership.save
        else 
          membership.role = member.role
          membership.save
        end
    end
  end
end
