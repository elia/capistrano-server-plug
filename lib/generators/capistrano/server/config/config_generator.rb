module Capistrano
  module Server
    class ConfigGenerator < Rails::Generators::NamedBase
      desc "Create local server configuration file for customization"
      source_root File.expand_path('../templates', __FILE__)

      def copy_template
        conf_name = CONFIGS[file_name]
        if conf_name.nil?
          raise ArgumentError, "unknown config: #{file_name.inspect} "+
                               "(available configs are: #{CONFIGS.keys.join(', ')})"
        end

        copy_file conf_name, "config/#{conf_name}"
      end

      CONFIGS = {
        'nginx' => 'nginx_conf.erb',
        'uwsgi' => 'uwsgi_conf.ini.erb',
      }
    end
  end
end
