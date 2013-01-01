# require 'bundler/capistrano'

set :application, "mlandcorp-pos"
set :repository,  "git@github.com:keikun17/mlandcorp-pos.git"
set :scm, "git"
set :deploy_to, "/home/deploy/apps/#{application}"
set :deploy_via, :checkout

set :bundle_gemfile,  "Gemfile"
# set :bundle_dir,      File.join(fetch(:shared_path), 'bundle')
set :bundle_flags,    "--deployment --quiet"
set :bundle_without,  [:development, :test]
set :bundle_cmd,      "/home/deploy/.rvm/gems/ruby-1.9.3-p194/bin/bundle" # e.g. "/opt/ruby/bin/bundle"
set :bundle_roles,    {:except => {:no_release => true}} # e.g. [:app, :batch]"

# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

task :production do
  set :branch, 'master'
  set :user, 'deploy'
  set :ssh_options, {:forward_agent => true}
  role :web, "106.187.50.117"
  role :app, "106.187.50.117"
  role :db, "106.187.50.117", :primary => true
end

namespace :symlink do
  task :db, :except => {:norelease => true} do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end

  task :uploads, :except => {:norelease => true} do
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads" 
  end
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:finalize_update", "symlink:db"
after "deploy:finalize_update", "symlink:uploads"

