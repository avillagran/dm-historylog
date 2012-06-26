require 'rails/generators'

module Historylog
    class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path('../files', __FILE__)

        desc "Install historial.rb"

        def install
            cp_file = "historial.rb"
            cp_path = "app/models/#{cp_file}"

            copy_file cp_file, cp_path

            
        end
    end
end