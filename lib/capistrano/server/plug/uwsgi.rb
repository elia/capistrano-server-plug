Capistrano::Server::Plug.load do
  namespace :uwsgi do
    desc 'Setup application in uwsgi'
    task :setup, :role => :web do
      config_file = 'config/uwsgi.ini.erb'
      unless File.exists?(config_file)
        config_file = File.expand_path('../../../generators/capistrano/uwsgi/templates/_uwsgi_conf.ini.erb', __FILE__)
      end
      config = ERB.new(File.read(config_file)).result(binding)
      conf_name = fetch(:uwsgi_conf_name, "#{application}-#{stage}.ini")

      set :user, sudo_user
      temp_file = '/tmp/#{conf_name}-#{$$}-#{Time.now.to_i}'
      put config, temp_name
      run "#{sudo} mv /tmp/#{conf_name} /etc/uwsgi/sites-available/#{conf_name}"
      run "#{sudo} ln -fs /etc/uwsgi/sites-available/#{conf_name} /etc/uwsgi/sites-enabled/#{conf_name}"
    end

    desc "Reload uwsgi configuration"
    task :reload, :role => :web do
      set :user, sudo_user
      run "#{sudo} /etc/init.d/uwsgi reload"
    end
  end
end
