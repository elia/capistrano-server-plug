Capistrano::Server::Plug.load do
  namespace :thin do
    set(:pid_path) { "#{current_path}/tmp/pids/server.pid" }
    set(:pid) { "$(cat #{pid_path})" }

    task :start do
      run "cd #{current_path} && ./script/rails server --port=#{web_port} --environment=#{deploy_env} --daemon"
    end

    task :stop do
      run "test -f #{pid_path} && kill -s TERM $(cat #{pid_path}) || true"
      run "while test -f #{pid_path}; do sleep 1; echo 'waiting for termination pid $(cat #{pid_path}) and for deletion of #{pid_path}...'; done"
    end

    task :restart do
      deploy.stop
      deploy.start
    end


    # SERVER STATUS

    task :status do
      run "ps u -p #{pid}"
    end
  end
end
