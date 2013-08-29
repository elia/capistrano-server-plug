require 'capistrano/server/plug/version'
require 'capistrano'

module Capistrano
  module Server
    module Plug

      Configuration.instance(true).load do
        namespace :deploy do
          task(:start)   { send(server_type).start }
          task(:stop)    { send(server_type).stop }
          task(:restart) { send(server_type).restart }
          task(:status)  { send(server_type).status }
        end


        namespace :torquebox do
          task :start do
            default_environment['JRUBY_OPTIONS'] = fetch(:jruby_options, nil)
            screen_name = "griglione_torquebox_#{deploy_env}"
            run %Q{#{jruby_options} cd #{current_path} && screen -dmS "#{screen_name}" bundle exec torquebox run -b #{server_host} -p #{web_port}}
            run %Q{screen -list | grep #{screen_name}}
          end
        end

        namespace :passenger do
          task :start do
            #noop
          end

          task :stop do
            #noop
          end

          task :restart do
            run %Q{touch "#{current_path}/tmp/restart.txt"}
          end

          task :status do
            #noop
          end
        end

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

    end
  end
end
