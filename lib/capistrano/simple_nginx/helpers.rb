require 'erb'

module Capistrano
  module SimpleNginx
    module Helpers
      def template template_name
        StringIO.new(template_to_s(template_name))
      end

      def template_to_s template_name
        config_file = File.join(File.dirname(__FILE__), "../../templates/#{template_name}")
        ERB.new(File.read(config_file), nil, '-').result(binding)
      end

      def sudo_upload! from, to
        filename = File.basename(to)
        to_dir = File.dirname(to)
        tmp_file = "/tmp/#{filename}"
        upload! from, tmp_file
        sudo :mv, tmp_file, to_dir
      end

      def file_exists? path
        test "[ -e #{path} ]"
      end

      def deploy_user
        capture :id, '-un'
      end

      def os_is_ubuntu?
        capture(:cat, "/etc/*-release").include? "ubuntu"
      end

      def nginx_config_file
        if os_is_ubuntu?
          "/etc/nginx/sites-available/#{fetch(:nginx_config_name)}.conf"
        else
          "/etc/nginx/conf.d/#{fetch(:nginx_config_name)}.conf"
        end
      end
    end
  end
end
