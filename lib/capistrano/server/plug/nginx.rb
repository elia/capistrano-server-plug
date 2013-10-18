Capistrano::Server::Plug.load do
  namespace :nginx do
    desc "Setup application in nginx"
    task "setup", :role => :web do
      config_file = Capistrano::Server::Plug.template_path(:nginx)
      config = ERB.new(File.read(config_file)).result(binding)
      set :user, sudo_user
      conf_name = fetch(:nginx_conf_name, application)

      put config, "/tmp/#{conf_name}"
      run "#{sudo} mv /tmp/#{conf_name} /etc/nginx/sites-available/#{conf_name}"
      run "#{sudo} ln -fs /etc/nginx/sites-available/#{conf_name} /etc/nginx/sites-enabled/#{conf_name}"
    end

    desc "Reload nginx configuration"
    task :reload, :role => :web do
      set :user, sudo_user
      run "#{sudo} /etc/init.d/nginx reload"
    end

    desc "Restart nginx"
    task :reload, :role => :web do
      set :user, sudo_user
      run "#{sudo} /etc/init.d/nginx restart"
    end

    desc "Add sites-available / sites-enabled configuration to your nginx installation"
    task :setup_sites_enabled do
      set :user, sudo_user
      run "#{sudo} mkdir -p /etc/nginx/sites-{enabled,available}"
      put 'include /etc/nginx/sites-enabled/*;', '/tmp/sites-enabled.conf'
      run "#{sudo} /tmp/sites-enabled.conf /etc/nginx/conf.d/sites-enabled.conf"
    end
  end
end
