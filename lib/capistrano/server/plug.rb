require 'capistrano/server/plug/version'
require 'capistrano'

module Capistrano
  module Server
    module Plug
      def self.load &block
        Configuration.instance(true).load(&:block) if defined? Configuration
      end
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
