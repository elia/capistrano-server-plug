require 'capistrano/server/plug/version'
require 'capistrano'

module Capistrano
  module Server
    module Plug
    end
  end
end

Configuration.instance(true).load do
  set :get_server, &lambda do
    require "capistrano/server/plug/#{server_type}"
    send(server_type)
  end

  namespace :deploy do
    task(:start)   { get_server.start }
    task(:stop)    { get_server.stop }
    task(:restart) { get_server.restart }
    task(:status)  { get_server.status }
  end
end
