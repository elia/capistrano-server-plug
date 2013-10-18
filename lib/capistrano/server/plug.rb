require 'capistrano/server/plug/version'
require 'capistrano'

module Capistrano
  module Server
    module Plug
      def self.load &block
        Configuration.instance(true).load(&:block)
      end

      def self.template_path(name)
        file_name = conf_name(name)
        file_path = Rails.root.join("config/#{file_name}")
        unless file_path.exist?
          file_path = File.expand_path("../../../generators/capistrano/server/config/templates/#{file_name}", __FILE__)
        end
        file_path.to_s
      end

      def self.conf_name(name)
        @conf_name ||= begin
          CONFIGS[name.to_s] || raise(ArgumentError, "unknown config: #{file_name.inspect} "+
                                       "(available configs are: #{CONFIGS.keys.join(', ')})")
        end
      end

      CONFIGS = {
        'nginx' => 'nginx_conf.erb',
        'uwsgi' => 'uwsgi_conf.ini.erb',
      }

    end
  end
end


Capistrano::Server::Plug.load do
  set :get_server, &lambda {
    require "capistrano/server/plug/#{server_type}"
    send(server_type)
  }

  namespace :deploy do
    task(:start)   { get_server.start }
    task(:stop)    { get_server.stop }
    task(:restart) { get_server.restart }
    task(:status)  { get_server.status }
  end
end
