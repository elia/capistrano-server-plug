Configuration.instance(true).load do
  namespace :torquebox do
    task :start do
      default_environment['JRUBY_OPTIONS'] = fetch(:jruby_options, nil)
      screen_name = "griglione_torquebox_#{deploy_env}"
      run %Q{#{jruby_options} cd #{current_path} && screen -dmS "#{screen_name}" bundle exec torquebox run -b #{server_host} -p #{web_port}}
      run %Q{screen -list | grep #{screen_name}}
    end
  end
end
