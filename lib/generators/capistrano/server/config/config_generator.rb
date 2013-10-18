module Capistrano
  module Server
    class ConfigGenerator < Rails::Generators::NamedBase
      desc "Create local server configuration file for customization"
      source_root File.expand_path('../templates', __FILE__)

      def copy_template
        copy_file conf_name, "config/#{conf_name}"
      end

      private

      def conf_name
        @conf_name ||= Plug.conf_name(file_name)
      end
    end
  end
end
