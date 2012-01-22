Capistrano::Configuration.instance.load do

  set :unicorn_binary, "bundle exec unicorn"
  set :unicorn_config, "config/unicorn.#{fetch(:stage, 'production')}.rb"
  set :unicorn_pid, "tmp/pids/unicorn.pid"

  namespace :deploy do
    task :start, :roles => :app, :except => { :no_release => true } do
      run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{current_path}/#{unicorn_config} -E #{rails_env} -D"
    end
    task :stop, :roles => :app, :except => { :no_release => true } do
      run "if [ -f #{current_path}/#{unicorn_pid} ]; then #{try_sudo} kill `cat #{current_path}/#{unicorn_pid}`; fi"
    end
    task :graceful_stop, :roles => :app, :except => { :no_release => true } do
      run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
    end
    task :restart, :roles => :app, :except => { :no_release => true } do
      stop
      start
    end
  end

end
