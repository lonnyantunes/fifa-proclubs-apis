module Fifa
  module Utils
    module GemFolder
      module Helper
        def self.root_folder
          lib_name = Environment::Helper.lib_name
          method_name = Environment::Helper.method_name
          if method_name.nil?
            gem_library(lib_name)
          else
            create_folder(File.join(gem_library(lib_name), method_name))
          end
        end

        def self.gem_library(library_name)
          create_gem_library(library_name)
        end

        def self.gem_folder(folder_name)
          create_gem_folder_for_library(folder_name)
        end

        def self.gem_file(file_name, folder_name)
          gem_folder_path = gem_folder(folder_name)
          create_file(File.join(gem_folder_path, file_name))
        end

        def self.create_gem_library(library_name)
          raise(ArgumentError, "library_name can't be nil") if library_name.nil?

          library_gem_folder = File.join(Dir.home, ".#{library_name}")
          FileUtils.mkdir_p(library_gem_folder) unless File.directory?(library_gem_folder)
          library_gem_folder
        end

        def self.create_gem_folder_for_library(folder_name)
          create_folder(File.join(root_folder, folder_name))
        end

        def self.create_folder(folder_path)
          FileUtils.mkdir_p(folder_path) unless File.directory?(folder_path)
          folder_path
        end

        def self.create_file(file_path)
          File.open(file_path, 'w') unless File.file?(file_path)
          file_path
        end

        private_class_method :create_gem_library, :create_gem_folder_for_library, :create_folder, :create_file
      end
    end
  end
end