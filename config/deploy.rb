#############################################################
#	Application
#############################################################
require 'mongrel_cluster/recipes'

set :application, "Plastic Surgery Friend"
set :deploy_to, "/data/ptbarnum_dev"
set :user, "root"
set :mongrel_conf, "#{current_path}config/mongrel_cluster.yml"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, true
set :scm_verbose, true
set :rails_env, "development" 
set :runner, nil

#############################################################
#	Servers
#############################################################

set :user, "root"
set :domain, "65.254.44.42"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	SGit
#############################################################

set :scm, "git"
set :repository, "git@github.com:michaeloboyle/ptbarnum.git"
set :branch, "master"
set :deploy_via, :remote_cache
#############################################################
#	Passenger
#############################################################

namespace :deploy do
  desc "Create the database yaml file"
  task :after_update_code do
    db_config = <<-EOF
    production:    
      adapter: mysql
      encoding: utf8
      username: wwwlike_psf
      password: u321!
      database: wwwlike_psf
      host: localhost
    development:    
      adapter: mysql
      encoding: utf8
      username: wwwlike_psf
      password: u321!
      database: wwwlike_psf
      host: localhost
    EOF
    
    put db_config, "#{release_path}/config/database.yml"
    
    #########################################################
    # Uncomment the following to symlink an uploads directory.
    # Just change the paths to whatever you need.
    #########################################################
    
    # desc "Symlink the upload directories"
    # task :before_symlink do
    #   run "mkdir -p #{shared_path}/uploads"
    #   run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
    # end
  
  end
  
  namespace :deploy do
    task :restart do
      restart_mongrel_cluster
    end
  end
  
end
