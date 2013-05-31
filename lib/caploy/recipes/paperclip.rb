Capistrano::Configuration.instance.load do

  namespace :deploy do
    desc "build missing paperclip styles"
    task :build_missing_paperclip_styles, :roles => :app do
      run "cd #{release_path}; RAILS_ENV=#{rails_env} #{rake} paperclip:refresh:missing_styles"
    end
  end

  #after("deploy:update_code", "deploy:build_missing_paperclip_styles")
end
